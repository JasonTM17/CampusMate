// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'CampusMate';

  @override
  String get navHome => 'Trang chủ';

  @override
  String get navAcademic => 'Học tập';

  @override
  String get navLibrary => 'Thư viện';

  @override
  String get navAi => 'AI';

  @override
  String get navProfile => 'Cá nhân';

  @override
  String get homeTagline => 'Học tập. Đọc sách. Phát triển.';

  @override
  String get comingSoonTitle => 'Sắp ra mắt';

  @override
  String get comingSoonMessage =>
      'Phần này sẽ được triển khai trong giai đoạn kế tiếp của lộ trình.';

  @override
  String get retry => 'Thử lại';

  @override
  String get errorGeneric => 'Đã xảy ra lỗi. Vui lòng thử lại.';

  @override
  String get emptyGeneric => 'Chưa có dữ liệu.';
}
