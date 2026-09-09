import 'package:serverpod/serverpod.dart';
import 'package:serverpod_client/serverpod_client.dart';

import '../../generated/protocol.dart';
import 'ai_preference_service.dart';

class AiMemoryService {
  AiMemoryService({AiPreferenceService? preferences})
    : _preferences = preferences ?? AiPreferenceService();

  final AiPreferenceService _preferences;

  static final _blocklistTerms = [
    'password',
    'mat_khau',
    'matkhau',
    'passphrase',
    'secret',
    'private_key',
    'bearer',
    'api_key',
    'apikey',
    'access_token',
    'refresh_token',
    'id_token',
    'auth_token',
    'cookie',
    'cvv',
    'cvc',
    'so_tai_khoan',
    'tai_khoan_ngan_hang',
  ];

  static final _blocklistRegexes = [
    // Credit card patterns: 13 to 16 digits
    RegExp(r'\b(?:\d[ -]*?){13,16}\b'),
    // CVV / CVC
    RegExp(r'\b(?:cvv|cvc)\s*[:=]?\s*\d{3,4}\b', caseSensitive: false),
    // STK / Bank account
    RegExp(
      r'\b(?:stk|so_tai_khoan|tai_khoan_ngan_hang)\s*[:=]?\s*\d{6,}\b',
      caseSensitive: false,
    ),
    // Bearer token / JWT
    RegExp(
      r'\b(?:bearer\s+)?[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\b',
      caseSensitive: false,
    ),
    // High entropy hex/base64 keys
    RegExp(r'\b(?:ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9]{36,}\b'),
  ];

  /// Checks if text contains sensitive credentials, financial, or auth patterns.
  static bool containsSensitiveData(String text) {
    final lower = text.toLowerCase();
    for (final term in _blocklistTerms) {
      if (lower.contains(term)) return true;
    }
    for (final regex in _blocklistRegexes) {
      if (regex.hasMatch(text)) return true;
    }
    return false;
  }

  /// Lists memories belonging to [userId].
  Future<List<AiUserMemory>> listMemories(
    Session session, {
    required UuidValue userId,
    bool activeOnly = true,
  }) async {
    return AiUserMemory.db.find(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          (activeOnly ? t.disabledAt.equals(null) : Constant.bool(true)),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }

  /// Adds a new memory for [userId] if personalization & memory are enabled
  /// and content does not violate sensitive data blocklist.
  Future<AiUserMemory> addMemory(
    Session session, {
    required UuidValue userId,
    required String content,
    String source = 'user',
  }) async {
    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      throw ServerpodClientException('Nội dung ghi nhớ không được rỗng', 400);
    }
    if (trimmed.length > 500) {
      throw ServerpodClientException(
        'Nội dung ghi nhớ tối đa 500 ký tự để đảm bảo giới hạn token',
        400,
      );
    }

    // Check user preference
    final pref = await _preferences.getPreferences(session, userId: userId);
    if (!pref.personalizationEnabled || !pref.memoryEnabled) {
      throw ServerpodClientException(
        'Bộ nhớ AI đang bị tắt trong cài đặt cá nhân hóa',
        400,
      );
    }

    // Check blocklist
    if (containsSensitiveData(trimmed)) {
      throw ServerpodClientException(
        'Nội dung chứa thông tin nhạy cảm hoặc bị chặn (mật khẩu, token, tài khoản...).',
        400,
      );
    }

    final memory = AiUserMemory(
      userId: userId,
      content: trimmed,
      source: source,
      createdAt: DateTime.now().toUtc(),
    );
    return AiUserMemory.db.insertRow(session, memory);
  }

  /// Toggles whether a memory is enabled or disabled.
  Future<AiUserMemory> toggleMemory(
    Session session, {
    required UuidValue userId,
    required int memoryId,
    required bool disabled,
  }) async {
    final memory = await AiUserMemory.db.findFirstRow(
      session,
      where: (t) => t.id.equals(memoryId) & t.userId.equals(userId),
    );
    if (memory == null) {
      throw ServerpodClientException('Không tìm thấy ghi nhớ', 404);
    }

    memory.disabledAt = disabled ? DateTime.now().toUtc() : null;
    return AiUserMemory.db.updateRow(session, memory);
  }

  /// Deletes a memory owned by [userId].
  Future<void> deleteMemory(
    Session session, {
    required UuidValue userId,
    required int memoryId,
  }) async {
    final deleted = await AiUserMemory.db.deleteWhere(
      session,
      where: (t) => t.id.equals(memoryId) & t.userId.equals(userId),
    );
    if (deleted.isEmpty) {
      throw ServerpodClientException('Không tìm thấy ghi nhớ', 404);
    }
  }
}
