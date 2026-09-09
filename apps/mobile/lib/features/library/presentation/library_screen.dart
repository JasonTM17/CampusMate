import 'dart:async';

import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../core/widgets/app_search_bar.dart';
import '../../../core/widgets/app_shimmer.dart';
import '../../../core/widgets/bouncing_widget.dart';
import '../application/library_controller.dart';
import '../domain/library_repository.dart';
import 'book_cover.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  final _queryController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreNearEnd);
  }

  @override
  void dispose() {
    _queryController.dispose();
    _scrollController
      ..removeListener(_loadMoreNearEnd)
      ..dispose();
    super.dispose();
  }

  void _loadMoreNearEnd() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.extentAfter > 320) return;
    final current = ref.read(libraryControllerProvider).value;
    if (current == null || !current.hasMore || current.isLoadingMore) return;
    unawaited(ref.read(libraryControllerProvider.notifier).loadMore());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(libraryControllerProvider);
    final query = state.value?.query ?? '';
    if (_queryController.text != query) {
      _queryController.value = TextEditingValue(
        text: query,
        selection: TextSelection.collapsed(offset: query.length),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thư viện'),
        actions: [
          IconButton(
            tooltip: 'Sách của tôi',
            onPressed: () => context.push('/library/loans'),
            icon: const Icon(Icons.assignment_outlined),
          ),
          IconButton(
            tooltip: 'Làm mới',
            onPressed: state.isLoading
                ? null
                : () => ref.read(libraryControllerProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: state.when(
        loading: () => const _LibrarySkeleton(),
        error: (error, stackTrace) => AppEmptyState(
          icon: Icons.cloud_off_outlined,
          title: 'Không tải được thư viện',
          message: 'Kiểm tra kết nối rồi thử lại.',
          actionLabel: 'Thử lại',
          onAction: () =>
              ref.read(libraryControllerProvider.notifier).refresh(),
        ),
        data: (data) => RefreshIndicator(
          onRefresh: () async {
            unawaited(HapticFeedback.lightImpact());
            await ref.read(libraryControllerProvider.notifier).refresh();
          },
          child: ListView(
            key: const Key('library-scroll-view'),
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.cardPadding,
              AppSpacing.m,
              AppSpacing.cardPadding,
              AppSpacing.xl,
            ),
            children: [
              AppSearchBar(
                controller: _queryController,
                hintText: 'Tìm tên sách, tác giả, ISBN, môn học...',
                onChanged: (value) => ref
                    .read(libraryControllerProvider.notifier)
                    .setQuery(value),
              ),
              const SizedBox(height: AppSpacing.s),
              _FilterToolbar(data: data),
              if (data.isSearching) ...[
                const SizedBox(height: AppSpacing.s),
                const LinearProgressIndicator(),
              ],
              if (data.showingExplore) ...[
                const SizedBox(height: AppSpacing.l),
                for (final section in data.explore.sections)
                  if (section.items.isNotEmpty)
                    _ExploreSection(section: section),
              ],
              const SizedBox(height: AppSpacing.l),
              _ResultHeader(data: data),
              const SizedBox(height: AppSpacing.s),
              if (data.items.isEmpty)
                AppEmptyState(
                  icon: Icons.manage_search_outlined,
                  title: 'Không tìm thấy tài liệu',
                  message: 'Thử đổi từ khóa hoặc bỏ bớt bộ lọc.',
                  actionLabel:
                      (data.filters.activeCount > 0 ||
                          _queryController.text.isNotEmpty)
                      ? 'Đặt lại tìm kiếm'
                      : null,
                  onAction:
                      (data.filters.activeCount > 0 ||
                          _queryController.text.isNotEmpty)
                      ? () {
                          _queryController.clear();
                          ref
                              .read(libraryControllerProvider.notifier)
                              .clearFilters();
                          ref
                              .read(libraryControllerProvider.notifier)
                              .setQuery('');
                        }
                      : null,
                )
              else
                for (final item in data.items) _BookSummaryTile(book: item),
              if (data.hasMore) ...[
                const SizedBox(height: AppSpacing.s),
                Center(
                  child: OutlinedButton.icon(
                    onPressed: data.isLoadingMore
                        ? null
                        : () => ref
                              .read(libraryControllerProvider.notifier)
                              .loadMore(),
                    icon: data.isLoadingMore
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.expand_more),
                    label: const Text('Tải thêm'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterToolbar extends ConsumerWidget {
  const _FilterToolbar({required this.data});

  final LibraryState data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        FilledButton.tonalIcon(
          onPressed: () => _showFilters(context, ref, data),
          style: FilledButton.styleFrom(minimumSize: const Size(0, 48)),
          icon: const Icon(Icons.tune),
          label: Text(
            data.filters.activeCount == 0
                ? 'Bộ lọc'
                : 'Bộ lọc (${data.filters.activeCount})',
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        if (!data.filters.isEmpty)
          IconButton(
            tooltip: 'Xóa bộ lọc',
            onPressed: () =>
                ref.read(libraryControllerProvider.notifier).clearFilters(),
            icon: const Icon(Icons.filter_alt_off_outlined),
          ),
      ],
    );
  }
}

Future<void> _showFilters(
  BuildContext context,
  WidgetRef ref,
  LibraryState data,
) async {
  var draft = data.filters;
  final options = data.explore.filterOptions;
  final applied = await showModalBottomSheet<LibraryFilters>(
    context: context,
    isScrollControlled: true,
    builder: (context) => StatefulBuilder(
      builder: (context, setModalState) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.cardPadding,
            AppSpacing.m,
            AppSpacing.cardPadding,
            AppSpacing.l,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Lọc thư viện',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Đóng',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                SwitchListTile(
                  value: draft.relatedToMyCourses,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Liên quan môn của tôi'),
                  onChanged: (value) => setModalState(
                    () => draft = draft.copyWith(relatedToMyCourses: value),
                  ),
                ),
                _ChipGroup<String>(
                  title: 'Định dạng',
                  values: options.formats,
                  selected: draft.formats,
                  labelFor: (value) => value,
                  onToggle: (value) => setModalState(
                    () => draft = draft.copyWith(
                      formats: _toggleString(draft.formats, value),
                    ),
                  ),
                ),
                _ChipGroup<String>(
                  title: 'Ngôn ngữ',
                  values: options.languages,
                  selected: draft.languages,
                  labelFor: _languageLabel,
                  onToggle: (value) => setModalState(
                    () => draft = draft.copyWith(
                      languages: _toggleString(draft.languages, value),
                    ),
                  ),
                ),
                _ChipGroup<BookAccessType>(
                  title: 'Quyền truy cập',
                  values: options.accessTypes,
                  selected: draft.accessTypes,
                  labelFor: accessTypeLabel,
                  onToggle: (value) => setModalState(
                    () => draft = draft.copyWith(
                      accessTypes: _toggleAccessType(draft.accessTypes, value),
                    ),
                  ),
                ),
                _ChipGroup<int>(
                  title: 'Năm xuất bản',
                  values: options.years.take(12).toList(),
                  selected: draft.years,
                  labelFor: (value) => value.toString(),
                  onToggle: (value) => setModalState(
                    () => draft = draft.copyWith(
                      years: _toggleInt(draft.years, value),
                    ),
                  ),
                ),
                _ChipGroup<String>(
                  title: 'Danh mục',
                  values: options.categories.take(16).toList(),
                  selected: draft.categories,
                  labelFor: (value) => value,
                  onToggle: (value) => setModalState(
                    () => draft = draft.copyWith(
                      categories: _toggleString(draft.categories, value),
                    ),
                  ),
                ),
                _ChipGroup<String>(
                  title: 'Tác giả',
                  values: options.authors.take(12).toList(),
                  selected: draft.authors,
                  labelFor: (value) => value,
                  onToggle: (value) => setModalState(
                    () => draft = draft.copyWith(
                      authors: _toggleString(draft.authors, value),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.m),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () =>
                            setModalState(() => draft = const LibraryFilters()),
                        icon: const Icon(Icons.filter_alt_off_outlined),
                        label: const Text('Đặt lại'),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.s),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => Navigator.of(context).pop(draft),
                        icon: const Icon(Icons.check),
                        label: const Text('Áp dụng'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  if (applied == null) return;
  await ref.read(libraryControllerProvider.notifier).applyFilters(applied);
}

class _ChipGroup<T> extends StatelessWidget {
  const _ChipGroup({
    required this.title,
    required this.values,
    required this.selected,
    required this.labelFor,
    required this.onToggle,
  });

  final String title;
  final List<T> values;
  final Set<T> selected;
  final String Function(T value) labelFor;
  final ValueChanged<T> onToggle;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppSpacing.s),
          Wrap(
            spacing: AppSpacing.s,
            runSpacing: AppSpacing.s,
            children: [
              for (final value in values)
                FilterChip(
                  label: Text(labelFor(value)),
                  selected: selected.contains(value),
                  onSelected: (_) => onToggle(value),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExploreSection extends StatelessWidget {
  const _ExploreSection({required this.section});

  final LibraryExploreSection section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.s),
          SizedBox(
            height: 260,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: section.items.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: AppSpacing.s),
              itemBuilder: (context, index) =>
                  _ExploreBookCard(book: section.items[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreBookCard extends ConsumerWidget {
  const _ExploreBookCard({required this.book});

  final BookSummary book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 148,
      child: BouncingWidget(
        onTap: () => context.push('/library/books/${book.id}'),
        enableHaptic: true,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: BookCover(
                    coverUrl: book.coverUrl,
                    width: 86,
                    height: 118,
                  ),
                ),
                const SizedBox(height: AppSpacing.s),
                Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  book.authors.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                _AccessChip(accessType: book.accessType),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultHeader extends StatelessWidget {
  const _ResultHeader({required this.data});

  final LibraryState data;

  @override
  Widget build(BuildContext context) {
    final title = data.showingExplore ? 'Tất cả tài liệu' : 'Kết quả';
    return Row(
      children: [
        Expanded(
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        Text(
          '${data.totalCount} mục',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}

class _BookSummaryTile extends ConsumerWidget {
  const _BookSummaryTile({required this.book});

  final BookSummary book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return BouncingWidget(
      onTap: () => context.push('/library/books/${book.id}'),
      enableHaptic: true,
      child: Card(
        margin: const EdgeInsets.only(bottom: AppSpacing.s),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookCover(coverUrl: book.coverUrl),
              const SizedBox(width: AppSpacing.s),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      book.authors.join(', '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${book.publisher} • ${book.publishedYear} • ${_languageLabel(book.language)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.s),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: [
                        _AccessChip(accessType: book.accessType),
                        for (final format in book.availableFormats)
                          Chip(label: Text(format)),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: book.isFavorite ? 'Bỏ yêu thích' : 'Yêu thích',
                onPressed: () async {
                  unawaited(HapticFeedback.lightImpact());
                  final status = await ref
                      .read(libraryRepositoryProvider)
                      .toggleFavorite(bookId: book.id);
                  ref
                      .read(libraryControllerProvider.notifier)
                      .updateFavoriteStatus(status);
                },
                icon: Icon(
                  book.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccessChip extends StatelessWidget {
  const _AccessChip({required this.accessType});

  final BookAccessType accessType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      label: Text(accessTypeLabel(accessType)),
      avatar: Icon(_accessIcon(accessType), size: 18),
      side: BorderSide(color: theme.colorScheme.outlineVariant),
    );
  }
}

Set<String> _toggleString(Set<String> values, String value) {
  final next = {...values};
  next.contains(value) ? next.remove(value) : next.add(value);
  return next;
}

Set<int> _toggleInt(Set<int> values, int value) {
  final next = {...values};
  next.contains(value) ? next.remove(value) : next.add(value);
  return next;
}

Set<BookAccessType> _toggleAccessType(
  Set<BookAccessType> values,
  BookAccessType value,
) {
  final next = {...values};
  next.contains(value) ? next.remove(value) : next.add(value);
  return next;
}

String accessTypeLabel(BookAccessType accessType) => switch (accessType) {
  BookAccessType.publicFullText => 'Mở công khai',
  BookAccessType.authenticatedFullText => 'Nội bộ',
  BookAccessType.borrowRequired => 'Cần mượn',
  BookAccessType.metadataOnly => 'Tham khảo',
  BookAccessType.restricted => 'Hạn chế',
};

IconData _accessIcon(BookAccessType accessType) => switch (accessType) {
  BookAccessType.publicFullText => Icons.public,
  BookAccessType.authenticatedFullText => Icons.verified_user_outlined,
  BookAccessType.borrowRequired => Icons.assignment_return_outlined,
  BookAccessType.metadataOnly => Icons.info_outline,
  BookAccessType.restricted => Icons.lock_outline,
};

String _languageLabel(String language) => switch (language.toLowerCase()) {
  'vi' => 'Tiếng Việt',
  'en' => 'English',
  _ => language.toUpperCase(),
};

class _LibrarySkeleton extends StatelessWidget {
  const _LibrarySkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.cardPadding,
        AppSpacing.m,
        AppSpacing.cardPadding,
        AppSpacing.xl,
      ),
      children: [
        const AppShimmer(width: double.infinity, height: 52),
        const SizedBox(height: AppSpacing.s),
        const AppShimmer(width: 120, height: 40),
        const SizedBox(height: AppSpacing.l),
        const AppShimmer(width: 180, height: 24),
        const SizedBox(height: AppSpacing.s),
        SizedBox(
          height: 240,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.s),
            itemBuilder: (_, _) => const AppShimmer(width: 148, height: 240),
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        const AppShimmer(width: 140, height: 24),
        const SizedBox(height: AppSpacing.s),
        for (var i = 0; i < 3; i++)
          const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.s),
            child: AppShimmer(width: double.infinity, height: 110),
          ),
      ],
    );
  }
}
