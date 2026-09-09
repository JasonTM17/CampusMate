/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'academic_overview.dart' as _i5;
import 'academic_year.dart' as _i6;
import 'ai_conversations.dart' as _i7;
import 'ai_messages.dart' as _i8;
import 'ai_usage.dart' as _i9;
import 'ai_user_memory.dart' as _i10;
import 'announcement.dart' as _i11;
import 'announcement_summary.dart' as _i12;
import 'audit_log.dart' as _i13;
import 'book_access_decision.dart' as _i14;
import 'book_access_policy_update.dart' as _i15;
import 'book_access_type.dart' as _i16;
import 'book_copy.dart' as _i17;
import 'book_copy_status.dart' as _i18;
import 'book_detail.dart' as _i19;
import 'book_favorite_status.dart' as _i20;
import 'book_loan.dart' as _i21;
import 'book_loan_page.dart' as _i22;
import 'book_loan_status.dart' as _i23;
import 'book_loan_summary.dart' as _i24;
import 'book_summary.dart' as _i25;
import 'campus_notification.dart' as _i26;
import 'campus_notification_summary.dart' as _i27;
import 'course.dart' as _i28;
import 'course_detail.dart' as _i29;
import 'course_offering.dart' as _i30;
import 'course_schedule.dart' as _i31;
import 'course_summary.dart' as _i32;
import 'curriculum_block_progress.dart' as _i33;
import 'curriculum_progress.dart' as _i34;
import 'dashboard_academic_summary.dart' as _i35;
import 'dashboard_greeting.dart' as _i36;
import 'enrollment.dart' as _i37;
import 'exam_schedule.dart' as _i38;
import 'exam_summary.dart' as _i39;
import 'favorite_book.dart' as _i40;
import 'grade_component.dart' as _i41;
import 'grade_component_score.dart' as _i42;
import 'grade_summary.dart' as _i43;
import 'greetings/greeting.dart' as _i44;
import 'library_author.dart' as _i45;
import 'library_book.dart' as _i46;
import 'library_book_author.dart' as _i47;
import 'library_book_category.dart' as _i48;
import 'library_book_course.dart' as _i49;
import 'library_book_file.dart' as _i50;
import 'library_category.dart' as _i51;
import 'library_explore.dart' as _i52;
import 'library_explore_section.dart' as _i53;
import 'library_filter_options.dart' as _i54;
import 'library_search_page.dart' as _i55;
import 'notification_list_page.dart' as _i56;
import 'reader_asset.dart' as _i57;
import 'reader_bookmark.dart' as _i58;
import 'reader_highlight.dart' as _i59;
import 'reader_note.dart' as _i60;
import 'reading_progress.dart' as _i61;
import 'reading_progress_sync_result.dart' as _i62;
import 'semester.dart' as _i63;
import 'semester_summary.dart' as _i64;
import 'student_ai_preference.dart' as _i65;
import 'student_grade.dart' as _i66;
import 'student_profile.dart' as _i67;
import 'study_suggestion.dart' as _i68;
import 'timetable_entry.dart' as _i69;
import 'vector_capability_probe.dart' as _i70;
import 'package:campusmate_server/src/generated/course_summary.dart' as _i71;
import 'package:campusmate_server/src/generated/timetable_entry.dart' as _i72;
import 'package:campusmate_server/src/generated/exam_summary.dart' as _i73;
import 'package:campusmate_server/src/generated/announcement_summary.dart'
    as _i74;
import 'package:campusmate_server/src/generated/ai_conversations.dart' as _i75;
import 'package:campusmate_server/src/generated/ai_messages.dart' as _i76;
import 'package:campusmate_server/src/generated/ai_user_memory.dart' as _i77;
import 'package:campusmate_server/src/generated/book_loan_summary.dart' as _i78;
import 'package:campusmate_server/src/generated/book_access_type.dart' as _i79;
import 'package:campusmate_server/src/generated/reader_bookmark.dart' as _i80;
import 'package:campusmate_server/src/generated/reader_note.dart' as _i81;
import 'package:campusmate_server/src/generated/reader_highlight.dart' as _i82;
export 'academic_overview.dart';
export 'academic_year.dart';
export 'ai_conversations.dart';
export 'ai_messages.dart';
export 'ai_usage.dart';
export 'ai_user_memory.dart';
export 'announcement.dart';
export 'announcement_summary.dart';
export 'audit_log.dart';
export 'book_access_decision.dart';
export 'book_access_policy_update.dart';
export 'book_access_type.dart';
export 'book_copy.dart';
export 'book_copy_status.dart';
export 'book_detail.dart';
export 'book_favorite_status.dart';
export 'book_loan.dart';
export 'book_loan_page.dart';
export 'book_loan_status.dart';
export 'book_loan_summary.dart';
export 'book_summary.dart';
export 'campus_notification.dart';
export 'campus_notification_summary.dart';
export 'course.dart';
export 'course_detail.dart';
export 'course_offering.dart';
export 'course_schedule.dart';
export 'course_summary.dart';
export 'curriculum_block_progress.dart';
export 'curriculum_progress.dart';
export 'dashboard_academic_summary.dart';
export 'dashboard_greeting.dart';
export 'enrollment.dart';
export 'exam_schedule.dart';
export 'exam_summary.dart';
export 'favorite_book.dart';
export 'grade_component.dart';
export 'grade_component_score.dart';
export 'grade_summary.dart';
export 'greetings/greeting.dart';
export 'library_author.dart';
export 'library_book.dart';
export 'library_book_author.dart';
export 'library_book_category.dart';
export 'library_book_course.dart';
export 'library_book_file.dart';
export 'library_category.dart';
export 'library_explore.dart';
export 'library_explore_section.dart';
export 'library_filter_options.dart';
export 'library_search_page.dart';
export 'notification_list_page.dart';
export 'reader_asset.dart';
export 'reader_bookmark.dart';
export 'reader_highlight.dart';
export 'reader_note.dart';
export 'reading_progress.dart';
export 'reading_progress_sync_result.dart';
export 'semester.dart';
export 'semester_summary.dart';
export 'student_ai_preference.dart';
export 'student_grade.dart';
export 'student_profile.dart';
export 'study_suggestion.dart';
export 'timetable_entry.dart';
export 'vector_capability_probe.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'academic_years',
      dartName: 'AcademicYear',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'academic_years_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'academic_years_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'academic_year_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ai_conversations',
      dartName: 'AiConversation',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ai_conversations_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ai_conversations_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ai_messages',
      dartName: 'AiMessage',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ai_messages_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'conversationId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'citations',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'feedback',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ai_messages_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'conversation_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'conversationId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ai_usage',
      dartName: 'AiUsage',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ai_usage_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'day',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'requestCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'inputTokens',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'outputTokens',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'estimatedCost',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ai_usage_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_day_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'day',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'ai_user_memories',
      dartName: 'AiUserMemory',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'ai_user_memories_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'source',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'disabledAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'ai_user_memories_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'ai_user_memory_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'announcements',
      dartName: 'Announcement',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'announcements_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'body',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'audience',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'publishAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'archived',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'announcements_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'announcement_audience_publish_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'audience',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'publishAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'announcement_publish_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'publishAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'audit_logs',
      dartName: 'AuditLog',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'audit_logs_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'actorUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'action',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'resourceType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'resourceId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'metadataJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'audit_logs_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'audit_actor_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'actorUserId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'audit_resource_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'resourceType',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'resourceId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'audit_action_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'action',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'authors',
      dartName: 'LibraryAuthor',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'authors_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'displayName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'normalizedName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'biography',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'authors_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'author_normalized_name_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'normalizedName',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'author_display_name_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'displayName',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book_authors',
      dartName: 'LibraryBookAuthor',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_authors_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'authorId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'book_authors_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'book_authors_fk_1',
          columns: ['authorId'],
          referenceTable: 'authors',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_authors_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_author_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authorId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_author_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_author_author_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authorId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book_categories',
      dartName: 'LibraryCategory',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_categories_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'slug',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_categories_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_category_slug_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'slug',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_category_name_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'name',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book_category_links',
      dartName: 'LibraryBookCategory',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_category_links_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'categoryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'book_category_links_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'book_category_links_fk_1',
          columns: ['categoryId'],
          referenceTable: 'book_categories',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_category_links_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_category_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'categoryId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_category_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_category_category_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'categoryId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book_copies',
      dartName: 'BookCopy',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_copies_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'barcode',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BookCopyStatus',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'book_copies_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_copies_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_copy_book_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_copy_barcode_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'barcode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book_course_links',
      dartName: 'LibraryBookCourse',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_course_links_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'courseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'book_course_links_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'book_course_links_fk_1',
          columns: ['courseId'],
          referenceTable: 'courses',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_course_links_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_course_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'courseId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_course_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_course_course_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'courseId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book_files',
      dartName: 'LibraryBookFile',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_files_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'format',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'storageKey',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'byteSize',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'checksum',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isPrimary',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'book_files_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_files_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_file_unique_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'format',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_file_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_file_format_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'format',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'book_loans',
      dartName: 'BookLoan',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'book_loans_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'copyId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'borrowedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'dueAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'returnedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BookLoanStatus',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'book_loans_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'book_loans_fk_1',
          columns: ['copyId'],
          referenceTable: 'book_copies',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.restrict,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'book_loans_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_loan_user_status_due_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'dueAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_loan_book_status_due_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'dueAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_loan_copy_status_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'copyId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'status',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'books',
      dartName: 'LibraryBook',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'books_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'subtitle',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isbn',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'publisher',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'publishedYear',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'language',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'coverUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'accessType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BookAccessType',
        ),
        _i2.ColumnDefinition(
          name: 'license',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'licenseExpiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'keywords',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'searchText',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'popularityScore',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'featuredRank',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'books_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'book_title_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'title',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_isbn_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isbn',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_access_type_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'accessType',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_language_year_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'language',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'publishedYear',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_featured_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'featuredRank',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_popularity_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'popularityScore',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_year_cursor_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'publishedYear',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'book_created_cursor_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'campus_notifications',
      dartName: 'CampusNotification',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'campus_notifications_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'body',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'targetType',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'targetId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'readAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'campus_notifications_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'notification_user_read_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'readAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'notification_user_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'notification_user_category_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'category',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'course_offerings',
      dartName: 'CourseOffering',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'course_offerings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'courseId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'semesterId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'section',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'lecturerName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'room',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'course_offerings_fk_0',
          columns: ['courseId'],
          referenceTable: 'courses',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'course_offerings_fk_1',
          columns: ['semesterId'],
          referenceTable: 'semesters',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'course_offerings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'offering_course_semester_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'courseId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'semesterId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'offering_semester_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'semesterId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'course_schedules',
      dartName: 'CourseSchedule',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'course_schedules_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'offeringId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'weekday',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'startMinute',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'endMinute',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'room',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'campus',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'course_schedules_fk_0',
          columns: ['offeringId'],
          referenceTable: 'course_offerings',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'course_schedules_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'schedule_offering_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'offeringId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'schedule_weekday_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'weekday',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'startMinute',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'courses',
      dartName: 'Course',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'courses_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'credits',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'faculty',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'department',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'courses_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'course_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'course_title_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'title',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'enrollments',
      dartName: 'Enrollment',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'enrollments_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'studentProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'offeringId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'progressPercent',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'attendancePercent',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'enrollments_fk_0',
          columns: ['studentProfileId'],
          referenceTable: 'student_profiles',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'enrollments_fk_1',
          columns: ['offeringId'],
          referenceTable: 'course_offerings',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'enrollments_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'enrollment_student_offering_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'studentProfileId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'offeringId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'enrollment_student_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'studentProfileId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'enrollment_offering_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'offeringId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'exam_schedules',
      dartName: 'ExamSchedule',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'exam_schedules_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'offeringId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'examType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'room',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'notes',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'exam_schedules_fk_0',
          columns: ['offeringId'],
          referenceTable: 'course_offerings',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'exam_schedules_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'exam_offering_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'offeringId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'exam_starts_at_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'startsAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'favorite_books',
      dartName: 'FavoriteBook',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'favorite_books_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'favorite_books_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'favorite_books_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'favorite_user_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'favorite_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'favorite_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'grade_components',
      dartName: 'GradeComponent',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'grade_components_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'offeringId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'maxScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'grade_components_fk_0',
          columns: ['offeringId'],
          referenceTable: 'course_offerings',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'grade_components_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'grade_component_offering_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'offeringId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'reader_bookmarks',
      dartName: 'ReaderBookmark',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'reader_bookmarks_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'reader_bookmarks_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'reader_bookmarks_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'reader_bookmark_user_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'reader_highlights',
      dartName: 'ReaderHighlight',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'reader_highlights_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'colorToken',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'reader_highlights_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'reader_highlights_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'reader_highlight_user_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'reader_notes',
      dartName: 'ReaderNote',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'reader_notes_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'location',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'reader_notes_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'reader_notes_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'reader_note_user_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'reading_progress',
      dartName: 'ReadingProgress',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'reading_progress_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'bookId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'progressPercent',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'currentLocation',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'reading_progress_fk_0',
          columns: ['bookId'],
          referenceTable: 'books',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'reading_progress_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'reading_progress_user_book_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'bookId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'reading_progress_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'semesters',
      dartName: 'Semester',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'semesters_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'academicYearId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'code',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isCurrent',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'semesters_fk_0',
          columns: ['academicYearId'],
          referenceTable: 'academic_years',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'semesters_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'semester_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'code',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'semester_current_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isCurrent',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'student_ai_preferences',
      dartName: 'StudentAiPreference',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'student_ai_preferences_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'explanationStyle',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'personalizationEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'memoryEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'student_ai_preferences_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'student_ai_pref_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'student_grades',
      dartName: 'StudentGrade',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'student_grades_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'enrollmentId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'componentName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'weight',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'maxScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'letter',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'gradedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'student_grades_fk_0',
          columns: ['enrollmentId'],
          referenceTable: 'enrollments',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'student_grades_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'student_grade_enrollment_component_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'enrollmentId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'componentName',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'student_grade_enrollment_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'enrollmentId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'student_profiles',
      dartName: 'StudentProfile',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'student_profiles_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'studentCode',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fullName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'faculty',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'major',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'className',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'gpa',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'credits',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'conductScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: true,
          dartType: 'double?',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'student_profiles_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'auth_user_id_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'student_code_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'studentCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'vector_capability_probe',
      dartName: 'VectorCapabilityProbe',
      schema: 'public',
      module: 'campusmate',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault:
              'nextval(\'vector_capability_probe_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'embedding',
          columnType: _i2.ColumnType.vector,
          isNullable: false,
          dartType: 'Vector(1536)',
          vectorDimension: 1536,
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'vector_capability_probe_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.AcademicOverview) {
      return _i5.AcademicOverview.fromJson(data) as T;
    }
    if (t == _i6.AcademicYear) {
      return _i6.AcademicYear.fromJson(data) as T;
    }
    if (t == _i7.AiConversation) {
      return _i7.AiConversation.fromJson(data) as T;
    }
    if (t == _i8.AiMessage) {
      return _i8.AiMessage.fromJson(data) as T;
    }
    if (t == _i9.AiUsage) {
      return _i9.AiUsage.fromJson(data) as T;
    }
    if (t == _i10.AiUserMemory) {
      return _i10.AiUserMemory.fromJson(data) as T;
    }
    if (t == _i11.Announcement) {
      return _i11.Announcement.fromJson(data) as T;
    }
    if (t == _i12.AnnouncementSummary) {
      return _i12.AnnouncementSummary.fromJson(data) as T;
    }
    if (t == _i13.AuditLog) {
      return _i13.AuditLog.fromJson(data) as T;
    }
    if (t == _i14.BookAccessDecision) {
      return _i14.BookAccessDecision.fromJson(data) as T;
    }
    if (t == _i15.BookAccessPolicyUpdate) {
      return _i15.BookAccessPolicyUpdate.fromJson(data) as T;
    }
    if (t == _i16.BookAccessType) {
      return _i16.BookAccessType.fromJson(data) as T;
    }
    if (t == _i17.BookCopy) {
      return _i17.BookCopy.fromJson(data) as T;
    }
    if (t == _i18.BookCopyStatus) {
      return _i18.BookCopyStatus.fromJson(data) as T;
    }
    if (t == _i19.BookDetail) {
      return _i19.BookDetail.fromJson(data) as T;
    }
    if (t == _i20.BookFavoriteStatus) {
      return _i20.BookFavoriteStatus.fromJson(data) as T;
    }
    if (t == _i21.BookLoan) {
      return _i21.BookLoan.fromJson(data) as T;
    }
    if (t == _i22.BookLoanPage) {
      return _i22.BookLoanPage.fromJson(data) as T;
    }
    if (t == _i23.BookLoanStatus) {
      return _i23.BookLoanStatus.fromJson(data) as T;
    }
    if (t == _i24.BookLoanSummary) {
      return _i24.BookLoanSummary.fromJson(data) as T;
    }
    if (t == _i25.BookSummary) {
      return _i25.BookSummary.fromJson(data) as T;
    }
    if (t == _i26.CampusNotification) {
      return _i26.CampusNotification.fromJson(data) as T;
    }
    if (t == _i27.CampusNotificationSummary) {
      return _i27.CampusNotificationSummary.fromJson(data) as T;
    }
    if (t == _i28.Course) {
      return _i28.Course.fromJson(data) as T;
    }
    if (t == _i29.CourseDetail) {
      return _i29.CourseDetail.fromJson(data) as T;
    }
    if (t == _i30.CourseOffering) {
      return _i30.CourseOffering.fromJson(data) as T;
    }
    if (t == _i31.CourseSchedule) {
      return _i31.CourseSchedule.fromJson(data) as T;
    }
    if (t == _i32.CourseSummary) {
      return _i32.CourseSummary.fromJson(data) as T;
    }
    if (t == _i33.CurriculumBlockProgress) {
      return _i33.CurriculumBlockProgress.fromJson(data) as T;
    }
    if (t == _i34.CurriculumProgress) {
      return _i34.CurriculumProgress.fromJson(data) as T;
    }
    if (t == _i35.DashboardAcademicSummary) {
      return _i35.DashboardAcademicSummary.fromJson(data) as T;
    }
    if (t == _i36.DashboardGreeting) {
      return _i36.DashboardGreeting.fromJson(data) as T;
    }
    if (t == _i37.Enrollment) {
      return _i37.Enrollment.fromJson(data) as T;
    }
    if (t == _i38.ExamSchedule) {
      return _i38.ExamSchedule.fromJson(data) as T;
    }
    if (t == _i39.ExamSummary) {
      return _i39.ExamSummary.fromJson(data) as T;
    }
    if (t == _i40.FavoriteBook) {
      return _i40.FavoriteBook.fromJson(data) as T;
    }
    if (t == _i41.GradeComponent) {
      return _i41.GradeComponent.fromJson(data) as T;
    }
    if (t == _i42.GradeComponentScore) {
      return _i42.GradeComponentScore.fromJson(data) as T;
    }
    if (t == _i43.GradeSummary) {
      return _i43.GradeSummary.fromJson(data) as T;
    }
    if (t == _i44.Greeting) {
      return _i44.Greeting.fromJson(data) as T;
    }
    if (t == _i45.LibraryAuthor) {
      return _i45.LibraryAuthor.fromJson(data) as T;
    }
    if (t == _i46.LibraryBook) {
      return _i46.LibraryBook.fromJson(data) as T;
    }
    if (t == _i47.LibraryBookAuthor) {
      return _i47.LibraryBookAuthor.fromJson(data) as T;
    }
    if (t == _i48.LibraryBookCategory) {
      return _i48.LibraryBookCategory.fromJson(data) as T;
    }
    if (t == _i49.LibraryBookCourse) {
      return _i49.LibraryBookCourse.fromJson(data) as T;
    }
    if (t == _i50.LibraryBookFile) {
      return _i50.LibraryBookFile.fromJson(data) as T;
    }
    if (t == _i51.LibraryCategory) {
      return _i51.LibraryCategory.fromJson(data) as T;
    }
    if (t == _i52.LibraryExplore) {
      return _i52.LibraryExplore.fromJson(data) as T;
    }
    if (t == _i53.LibraryExploreSection) {
      return _i53.LibraryExploreSection.fromJson(data) as T;
    }
    if (t == _i54.LibraryFilterOptions) {
      return _i54.LibraryFilterOptions.fromJson(data) as T;
    }
    if (t == _i55.LibrarySearchPage) {
      return _i55.LibrarySearchPage.fromJson(data) as T;
    }
    if (t == _i56.NotificationListPage) {
      return _i56.NotificationListPage.fromJson(data) as T;
    }
    if (t == _i57.ReaderAsset) {
      return _i57.ReaderAsset.fromJson(data) as T;
    }
    if (t == _i58.ReaderBookmark) {
      return _i58.ReaderBookmark.fromJson(data) as T;
    }
    if (t == _i59.ReaderHighlight) {
      return _i59.ReaderHighlight.fromJson(data) as T;
    }
    if (t == _i60.ReaderNote) {
      return _i60.ReaderNote.fromJson(data) as T;
    }
    if (t == _i61.ReadingProgress) {
      return _i61.ReadingProgress.fromJson(data) as T;
    }
    if (t == _i62.ReadingProgressSyncResult) {
      return _i62.ReadingProgressSyncResult.fromJson(data) as T;
    }
    if (t == _i63.Semester) {
      return _i63.Semester.fromJson(data) as T;
    }
    if (t == _i64.SemesterSummary) {
      return _i64.SemesterSummary.fromJson(data) as T;
    }
    if (t == _i65.StudentAiPreference) {
      return _i65.StudentAiPreference.fromJson(data) as T;
    }
    if (t == _i66.StudentGrade) {
      return _i66.StudentGrade.fromJson(data) as T;
    }
    if (t == _i67.StudentProfile) {
      return _i67.StudentProfile.fromJson(data) as T;
    }
    if (t == _i68.StudySuggestion) {
      return _i68.StudySuggestion.fromJson(data) as T;
    }
    if (t == _i69.TimetableEntry) {
      return _i69.TimetableEntry.fromJson(data) as T;
    }
    if (t == _i70.VectorCapabilityProbe) {
      return _i70.VectorCapabilityProbe.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AcademicOverview?>()) {
      return (data != null ? _i5.AcademicOverview.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AcademicYear?>()) {
      return (data != null ? _i6.AcademicYear.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AiConversation?>()) {
      return (data != null ? _i7.AiConversation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AiMessage?>()) {
      return (data != null ? _i8.AiMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AiUsage?>()) {
      return (data != null ? _i9.AiUsage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.AiUserMemory?>()) {
      return (data != null ? _i10.AiUserMemory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.Announcement?>()) {
      return (data != null ? _i11.Announcement.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AnnouncementSummary?>()) {
      return (data != null ? _i12.AnnouncementSummary.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.AuditLog?>()) {
      return (data != null ? _i13.AuditLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.BookAccessDecision?>()) {
      return (data != null ? _i14.BookAccessDecision.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.BookAccessPolicyUpdate?>()) {
      return (data != null ? _i15.BookAccessPolicyUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.BookAccessType?>()) {
      return (data != null ? _i16.BookAccessType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.BookCopy?>()) {
      return (data != null ? _i17.BookCopy.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.BookCopyStatus?>()) {
      return (data != null ? _i18.BookCopyStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.BookDetail?>()) {
      return (data != null ? _i19.BookDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.BookFavoriteStatus?>()) {
      return (data != null ? _i20.BookFavoriteStatus.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.BookLoan?>()) {
      return (data != null ? _i21.BookLoan.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.BookLoanPage?>()) {
      return (data != null ? _i22.BookLoanPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.BookLoanStatus?>()) {
      return (data != null ? _i23.BookLoanStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.BookLoanSummary?>()) {
      return (data != null ? _i24.BookLoanSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.BookSummary?>()) {
      return (data != null ? _i25.BookSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.CampusNotification?>()) {
      return (data != null ? _i26.CampusNotification.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.CampusNotificationSummary?>()) {
      return (data != null
              ? _i27.CampusNotificationSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i28.Course?>()) {
      return (data != null ? _i28.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.CourseDetail?>()) {
      return (data != null ? _i29.CourseDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.CourseOffering?>()) {
      return (data != null ? _i30.CourseOffering.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.CourseSchedule?>()) {
      return (data != null ? _i31.CourseSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.CourseSummary?>()) {
      return (data != null ? _i32.CourseSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.CurriculumBlockProgress?>()) {
      return (data != null ? _i33.CurriculumBlockProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i34.CurriculumProgress?>()) {
      return (data != null ? _i34.CurriculumProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i35.DashboardAcademicSummary?>()) {
      return (data != null
              ? _i35.DashboardAcademicSummary.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i36.DashboardGreeting?>()) {
      return (data != null ? _i36.DashboardGreeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i37.Enrollment?>()) {
      return (data != null ? _i37.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.ExamSchedule?>()) {
      return (data != null ? _i38.ExamSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.ExamSummary?>()) {
      return (data != null ? _i39.ExamSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i40.FavoriteBook?>()) {
      return (data != null ? _i40.FavoriteBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i41.GradeComponent?>()) {
      return (data != null ? _i41.GradeComponent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.GradeComponentScore?>()) {
      return (data != null ? _i42.GradeComponentScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i43.GradeSummary?>()) {
      return (data != null ? _i43.GradeSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.Greeting?>()) {
      return (data != null ? _i44.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i45.LibraryAuthor?>()) {
      return (data != null ? _i45.LibraryAuthor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.LibraryBook?>()) {
      return (data != null ? _i46.LibraryBook.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.LibraryBookAuthor?>()) {
      return (data != null ? _i47.LibraryBookAuthor.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.LibraryBookCategory?>()) {
      return (data != null ? _i48.LibraryBookCategory.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i49.LibraryBookCourse?>()) {
      return (data != null ? _i49.LibraryBookCourse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.LibraryBookFile?>()) {
      return (data != null ? _i50.LibraryBookFile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i51.LibraryCategory?>()) {
      return (data != null ? _i51.LibraryCategory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.LibraryExplore?>()) {
      return (data != null ? _i52.LibraryExplore.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.LibraryExploreSection?>()) {
      return (data != null ? _i53.LibraryExploreSection.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i54.LibraryFilterOptions?>()) {
      return (data != null ? _i54.LibraryFilterOptions.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.LibrarySearchPage?>()) {
      return (data != null ? _i55.LibrarySearchPage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i56.NotificationListPage?>()) {
      return (data != null ? _i56.NotificationListPage.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i57.ReaderAsset?>()) {
      return (data != null ? _i57.ReaderAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.ReaderBookmark?>()) {
      return (data != null ? _i58.ReaderBookmark.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.ReaderHighlight?>()) {
      return (data != null ? _i59.ReaderHighlight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.ReaderNote?>()) {
      return (data != null ? _i60.ReaderNote.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i61.ReadingProgress?>()) {
      return (data != null ? _i61.ReadingProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.ReadingProgressSyncResult?>()) {
      return (data != null
              ? _i62.ReadingProgressSyncResult.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i63.Semester?>()) {
      return (data != null ? _i63.Semester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.SemesterSummary?>()) {
      return (data != null ? _i64.SemesterSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.StudentAiPreference?>()) {
      return (data != null ? _i65.StudentAiPreference.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i66.StudentGrade?>()) {
      return (data != null ? _i66.StudentGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i67.StudentProfile?>()) {
      return (data != null ? _i67.StudentProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i68.StudySuggestion?>()) {
      return (data != null ? _i68.StudySuggestion.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i69.TimetableEntry?>()) {
      return (data != null ? _i69.TimetableEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i70.VectorCapabilityProbe?>()) {
      return (data != null ? _i70.VectorCapabilityProbe.fromJson(data) : null)
          as T;
    }
    if (t == List<_i64.SemesterSummary>) {
      return (data as List)
              .map((e) => deserialize<_i64.SemesterSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i32.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i69.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i69.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i39.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i39.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i24.BookLoanSummary>) {
      return (data as List)
              .map((e) => deserialize<_i24.BookLoanSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i42.GradeComponentScore>) {
      return (data as List)
              .map((e) => deserialize<_i42.GradeComponentScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.CurriculumBlockProgress>) {
      return (data as List)
              .map((e) => deserialize<_i33.CurriculumBlockProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i53.LibraryExploreSection>) {
      return (data as List)
              .map((e) => deserialize<_i53.LibraryExploreSection>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.BookSummary>) {
      return (data as List)
              .map((e) => deserialize<_i25.BookSummary>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i16.BookAccessType>) {
      return (data as List)
              .map((e) => deserialize<_i16.BookAccessType>(e))
              .toList()
          as T;
    }
    if (t == List<_i27.CampusNotificationSummary>) {
      return (data as List)
              .map((e) => deserialize<_i27.CampusNotificationSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i71.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i71.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i72.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i72.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i73.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i73.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i74.AnnouncementSummary>) {
      return (data as List)
              .map((e) => deserialize<_i74.AnnouncementSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i75.AiConversation>) {
      return (data as List)
              .map((e) => deserialize<_i75.AiConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_i76.AiMessage>) {
      return (data as List).map((e) => deserialize<_i76.AiMessage>(e)).toList()
          as T;
    }
    if (t == List<_i77.AiUserMemory>) {
      return (data as List)
              .map((e) => deserialize<_i77.AiUserMemory>(e))
              .toList()
          as T;
    }
    if (t == List<_i78.BookLoanSummary>) {
      return (data as List)
              .map((e) => deserialize<_i78.BookLoanSummary>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i79.BookAccessType>) {
      return (data as List)
              .map((e) => deserialize<_i79.BookAccessType>(e))
              .toList()
          as T;
    }
    if (t == _i1.getType<List<_i79.BookAccessType>?>()) {
      return (data != null
              ? (data as List)
                    .map((e) => deserialize<_i79.BookAccessType>(e))
                    .toList()
              : null)
          as T;
    }
    if (t == List<_i80.ReaderBookmark>) {
      return (data as List)
              .map((e) => deserialize<_i80.ReaderBookmark>(e))
              .toList()
          as T;
    }
    if (t == List<_i81.ReaderNote>) {
      return (data as List).map((e) => deserialize<_i81.ReaderNote>(e)).toList()
          as T;
    }
    if (t == List<_i82.ReaderHighlight>) {
      return (data as List)
              .map((e) => deserialize<_i82.ReaderHighlight>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AcademicOverview => 'AcademicOverview',
      _i6.AcademicYear => 'AcademicYear',
      _i7.AiConversation => 'AiConversation',
      _i8.AiMessage => 'AiMessage',
      _i9.AiUsage => 'AiUsage',
      _i10.AiUserMemory => 'AiUserMemory',
      _i11.Announcement => 'Announcement',
      _i12.AnnouncementSummary => 'AnnouncementSummary',
      _i13.AuditLog => 'AuditLog',
      _i14.BookAccessDecision => 'BookAccessDecision',
      _i15.BookAccessPolicyUpdate => 'BookAccessPolicyUpdate',
      _i16.BookAccessType => 'BookAccessType',
      _i17.BookCopy => 'BookCopy',
      _i18.BookCopyStatus => 'BookCopyStatus',
      _i19.BookDetail => 'BookDetail',
      _i20.BookFavoriteStatus => 'BookFavoriteStatus',
      _i21.BookLoan => 'BookLoan',
      _i22.BookLoanPage => 'BookLoanPage',
      _i23.BookLoanStatus => 'BookLoanStatus',
      _i24.BookLoanSummary => 'BookLoanSummary',
      _i25.BookSummary => 'BookSummary',
      _i26.CampusNotification => 'CampusNotification',
      _i27.CampusNotificationSummary => 'CampusNotificationSummary',
      _i28.Course => 'Course',
      _i29.CourseDetail => 'CourseDetail',
      _i30.CourseOffering => 'CourseOffering',
      _i31.CourseSchedule => 'CourseSchedule',
      _i32.CourseSummary => 'CourseSummary',
      _i33.CurriculumBlockProgress => 'CurriculumBlockProgress',
      _i34.CurriculumProgress => 'CurriculumProgress',
      _i35.DashboardAcademicSummary => 'DashboardAcademicSummary',
      _i36.DashboardGreeting => 'DashboardGreeting',
      _i37.Enrollment => 'Enrollment',
      _i38.ExamSchedule => 'ExamSchedule',
      _i39.ExamSummary => 'ExamSummary',
      _i40.FavoriteBook => 'FavoriteBook',
      _i41.GradeComponent => 'GradeComponent',
      _i42.GradeComponentScore => 'GradeComponentScore',
      _i43.GradeSummary => 'GradeSummary',
      _i44.Greeting => 'Greeting',
      _i45.LibraryAuthor => 'LibraryAuthor',
      _i46.LibraryBook => 'LibraryBook',
      _i47.LibraryBookAuthor => 'LibraryBookAuthor',
      _i48.LibraryBookCategory => 'LibraryBookCategory',
      _i49.LibraryBookCourse => 'LibraryBookCourse',
      _i50.LibraryBookFile => 'LibraryBookFile',
      _i51.LibraryCategory => 'LibraryCategory',
      _i52.LibraryExplore => 'LibraryExplore',
      _i53.LibraryExploreSection => 'LibraryExploreSection',
      _i54.LibraryFilterOptions => 'LibraryFilterOptions',
      _i55.LibrarySearchPage => 'LibrarySearchPage',
      _i56.NotificationListPage => 'NotificationListPage',
      _i57.ReaderAsset => 'ReaderAsset',
      _i58.ReaderBookmark => 'ReaderBookmark',
      _i59.ReaderHighlight => 'ReaderHighlight',
      _i60.ReaderNote => 'ReaderNote',
      _i61.ReadingProgress => 'ReadingProgress',
      _i62.ReadingProgressSyncResult => 'ReadingProgressSyncResult',
      _i63.Semester => 'Semester',
      _i64.SemesterSummary => 'SemesterSummary',
      _i65.StudentAiPreference => 'StudentAiPreference',
      _i66.StudentGrade => 'StudentGrade',
      _i67.StudentProfile => 'StudentProfile',
      _i68.StudySuggestion => 'StudySuggestion',
      _i69.TimetableEntry => 'TimetableEntry',
      _i70.VectorCapabilityProbe => 'VectorCapabilityProbe',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('campusmate.', '');
    }

    switch (data) {
      case _i5.AcademicOverview():
        return 'AcademicOverview';
      case _i6.AcademicYear():
        return 'AcademicYear';
      case _i7.AiConversation():
        return 'AiConversation';
      case _i8.AiMessage():
        return 'AiMessage';
      case _i9.AiUsage():
        return 'AiUsage';
      case _i10.AiUserMemory():
        return 'AiUserMemory';
      case _i11.Announcement():
        return 'Announcement';
      case _i12.AnnouncementSummary():
        return 'AnnouncementSummary';
      case _i13.AuditLog():
        return 'AuditLog';
      case _i14.BookAccessDecision():
        return 'BookAccessDecision';
      case _i15.BookAccessPolicyUpdate():
        return 'BookAccessPolicyUpdate';
      case _i16.BookAccessType():
        return 'BookAccessType';
      case _i17.BookCopy():
        return 'BookCopy';
      case _i18.BookCopyStatus():
        return 'BookCopyStatus';
      case _i19.BookDetail():
        return 'BookDetail';
      case _i20.BookFavoriteStatus():
        return 'BookFavoriteStatus';
      case _i21.BookLoan():
        return 'BookLoan';
      case _i22.BookLoanPage():
        return 'BookLoanPage';
      case _i23.BookLoanStatus():
        return 'BookLoanStatus';
      case _i24.BookLoanSummary():
        return 'BookLoanSummary';
      case _i25.BookSummary():
        return 'BookSummary';
      case _i26.CampusNotification():
        return 'CampusNotification';
      case _i27.CampusNotificationSummary():
        return 'CampusNotificationSummary';
      case _i28.Course():
        return 'Course';
      case _i29.CourseDetail():
        return 'CourseDetail';
      case _i30.CourseOffering():
        return 'CourseOffering';
      case _i31.CourseSchedule():
        return 'CourseSchedule';
      case _i32.CourseSummary():
        return 'CourseSummary';
      case _i33.CurriculumBlockProgress():
        return 'CurriculumBlockProgress';
      case _i34.CurriculumProgress():
        return 'CurriculumProgress';
      case _i35.DashboardAcademicSummary():
        return 'DashboardAcademicSummary';
      case _i36.DashboardGreeting():
        return 'DashboardGreeting';
      case _i37.Enrollment():
        return 'Enrollment';
      case _i38.ExamSchedule():
        return 'ExamSchedule';
      case _i39.ExamSummary():
        return 'ExamSummary';
      case _i40.FavoriteBook():
        return 'FavoriteBook';
      case _i41.GradeComponent():
        return 'GradeComponent';
      case _i42.GradeComponentScore():
        return 'GradeComponentScore';
      case _i43.GradeSummary():
        return 'GradeSummary';
      case _i44.Greeting():
        return 'Greeting';
      case _i45.LibraryAuthor():
        return 'LibraryAuthor';
      case _i46.LibraryBook():
        return 'LibraryBook';
      case _i47.LibraryBookAuthor():
        return 'LibraryBookAuthor';
      case _i48.LibraryBookCategory():
        return 'LibraryBookCategory';
      case _i49.LibraryBookCourse():
        return 'LibraryBookCourse';
      case _i50.LibraryBookFile():
        return 'LibraryBookFile';
      case _i51.LibraryCategory():
        return 'LibraryCategory';
      case _i52.LibraryExplore():
        return 'LibraryExplore';
      case _i53.LibraryExploreSection():
        return 'LibraryExploreSection';
      case _i54.LibraryFilterOptions():
        return 'LibraryFilterOptions';
      case _i55.LibrarySearchPage():
        return 'LibrarySearchPage';
      case _i56.NotificationListPage():
        return 'NotificationListPage';
      case _i57.ReaderAsset():
        return 'ReaderAsset';
      case _i58.ReaderBookmark():
        return 'ReaderBookmark';
      case _i59.ReaderHighlight():
        return 'ReaderHighlight';
      case _i60.ReaderNote():
        return 'ReaderNote';
      case _i61.ReadingProgress():
        return 'ReadingProgress';
      case _i62.ReadingProgressSyncResult():
        return 'ReadingProgressSyncResult';
      case _i63.Semester():
        return 'Semester';
      case _i64.SemesterSummary():
        return 'SemesterSummary';
      case _i65.StudentAiPreference():
        return 'StudentAiPreference';
      case _i66.StudentGrade():
        return 'StudentGrade';
      case _i67.StudentProfile():
        return 'StudentProfile';
      case _i68.StudySuggestion():
        return 'StudySuggestion';
      case _i69.TimetableEntry():
        return 'TimetableEntry';
      case _i70.VectorCapabilityProbe():
        return 'VectorCapabilityProbe';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AcademicOverview') {
      return deserialize<_i5.AcademicOverview>(data['data']);
    }
    if (dataClassName == 'AcademicYear') {
      return deserialize<_i6.AcademicYear>(data['data']);
    }
    if (dataClassName == 'AiConversation') {
      return deserialize<_i7.AiConversation>(data['data']);
    }
    if (dataClassName == 'AiMessage') {
      return deserialize<_i8.AiMessage>(data['data']);
    }
    if (dataClassName == 'AiUsage') {
      return deserialize<_i9.AiUsage>(data['data']);
    }
    if (dataClassName == 'AiUserMemory') {
      return deserialize<_i10.AiUserMemory>(data['data']);
    }
    if (dataClassName == 'Announcement') {
      return deserialize<_i11.Announcement>(data['data']);
    }
    if (dataClassName == 'AnnouncementSummary') {
      return deserialize<_i12.AnnouncementSummary>(data['data']);
    }
    if (dataClassName == 'AuditLog') {
      return deserialize<_i13.AuditLog>(data['data']);
    }
    if (dataClassName == 'BookAccessDecision') {
      return deserialize<_i14.BookAccessDecision>(data['data']);
    }
    if (dataClassName == 'BookAccessPolicyUpdate') {
      return deserialize<_i15.BookAccessPolicyUpdate>(data['data']);
    }
    if (dataClassName == 'BookAccessType') {
      return deserialize<_i16.BookAccessType>(data['data']);
    }
    if (dataClassName == 'BookCopy') {
      return deserialize<_i17.BookCopy>(data['data']);
    }
    if (dataClassName == 'BookCopyStatus') {
      return deserialize<_i18.BookCopyStatus>(data['data']);
    }
    if (dataClassName == 'BookDetail') {
      return deserialize<_i19.BookDetail>(data['data']);
    }
    if (dataClassName == 'BookFavoriteStatus') {
      return deserialize<_i20.BookFavoriteStatus>(data['data']);
    }
    if (dataClassName == 'BookLoan') {
      return deserialize<_i21.BookLoan>(data['data']);
    }
    if (dataClassName == 'BookLoanPage') {
      return deserialize<_i22.BookLoanPage>(data['data']);
    }
    if (dataClassName == 'BookLoanStatus') {
      return deserialize<_i23.BookLoanStatus>(data['data']);
    }
    if (dataClassName == 'BookLoanSummary') {
      return deserialize<_i24.BookLoanSummary>(data['data']);
    }
    if (dataClassName == 'BookSummary') {
      return deserialize<_i25.BookSummary>(data['data']);
    }
    if (dataClassName == 'CampusNotification') {
      return deserialize<_i26.CampusNotification>(data['data']);
    }
    if (dataClassName == 'CampusNotificationSummary') {
      return deserialize<_i27.CampusNotificationSummary>(data['data']);
    }
    if (dataClassName == 'Course') {
      return deserialize<_i28.Course>(data['data']);
    }
    if (dataClassName == 'CourseDetail') {
      return deserialize<_i29.CourseDetail>(data['data']);
    }
    if (dataClassName == 'CourseOffering') {
      return deserialize<_i30.CourseOffering>(data['data']);
    }
    if (dataClassName == 'CourseSchedule') {
      return deserialize<_i31.CourseSchedule>(data['data']);
    }
    if (dataClassName == 'CourseSummary') {
      return deserialize<_i32.CourseSummary>(data['data']);
    }
    if (dataClassName == 'CurriculumBlockProgress') {
      return deserialize<_i33.CurriculumBlockProgress>(data['data']);
    }
    if (dataClassName == 'CurriculumProgress') {
      return deserialize<_i34.CurriculumProgress>(data['data']);
    }
    if (dataClassName == 'DashboardAcademicSummary') {
      return deserialize<_i35.DashboardAcademicSummary>(data['data']);
    }
    if (dataClassName == 'DashboardGreeting') {
      return deserialize<_i36.DashboardGreeting>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i37.Enrollment>(data['data']);
    }
    if (dataClassName == 'ExamSchedule') {
      return deserialize<_i38.ExamSchedule>(data['data']);
    }
    if (dataClassName == 'ExamSummary') {
      return deserialize<_i39.ExamSummary>(data['data']);
    }
    if (dataClassName == 'FavoriteBook') {
      return deserialize<_i40.FavoriteBook>(data['data']);
    }
    if (dataClassName == 'GradeComponent') {
      return deserialize<_i41.GradeComponent>(data['data']);
    }
    if (dataClassName == 'GradeComponentScore') {
      return deserialize<_i42.GradeComponentScore>(data['data']);
    }
    if (dataClassName == 'GradeSummary') {
      return deserialize<_i43.GradeSummary>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i44.Greeting>(data['data']);
    }
    if (dataClassName == 'LibraryAuthor') {
      return deserialize<_i45.LibraryAuthor>(data['data']);
    }
    if (dataClassName == 'LibraryBook') {
      return deserialize<_i46.LibraryBook>(data['data']);
    }
    if (dataClassName == 'LibraryBookAuthor') {
      return deserialize<_i47.LibraryBookAuthor>(data['data']);
    }
    if (dataClassName == 'LibraryBookCategory') {
      return deserialize<_i48.LibraryBookCategory>(data['data']);
    }
    if (dataClassName == 'LibraryBookCourse') {
      return deserialize<_i49.LibraryBookCourse>(data['data']);
    }
    if (dataClassName == 'LibraryBookFile') {
      return deserialize<_i50.LibraryBookFile>(data['data']);
    }
    if (dataClassName == 'LibraryCategory') {
      return deserialize<_i51.LibraryCategory>(data['data']);
    }
    if (dataClassName == 'LibraryExplore') {
      return deserialize<_i52.LibraryExplore>(data['data']);
    }
    if (dataClassName == 'LibraryExploreSection') {
      return deserialize<_i53.LibraryExploreSection>(data['data']);
    }
    if (dataClassName == 'LibraryFilterOptions') {
      return deserialize<_i54.LibraryFilterOptions>(data['data']);
    }
    if (dataClassName == 'LibrarySearchPage') {
      return deserialize<_i55.LibrarySearchPage>(data['data']);
    }
    if (dataClassName == 'NotificationListPage') {
      return deserialize<_i56.NotificationListPage>(data['data']);
    }
    if (dataClassName == 'ReaderAsset') {
      return deserialize<_i57.ReaderAsset>(data['data']);
    }
    if (dataClassName == 'ReaderBookmark') {
      return deserialize<_i58.ReaderBookmark>(data['data']);
    }
    if (dataClassName == 'ReaderHighlight') {
      return deserialize<_i59.ReaderHighlight>(data['data']);
    }
    if (dataClassName == 'ReaderNote') {
      return deserialize<_i60.ReaderNote>(data['data']);
    }
    if (dataClassName == 'ReadingProgress') {
      return deserialize<_i61.ReadingProgress>(data['data']);
    }
    if (dataClassName == 'ReadingProgressSyncResult') {
      return deserialize<_i62.ReadingProgressSyncResult>(data['data']);
    }
    if (dataClassName == 'Semester') {
      return deserialize<_i63.Semester>(data['data']);
    }
    if (dataClassName == 'SemesterSummary') {
      return deserialize<_i64.SemesterSummary>(data['data']);
    }
    if (dataClassName == 'StudentAiPreference') {
      return deserialize<_i65.StudentAiPreference>(data['data']);
    }
    if (dataClassName == 'StudentGrade') {
      return deserialize<_i66.StudentGrade>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_i67.StudentProfile>(data['data']);
    }
    if (dataClassName == 'StudySuggestion') {
      return deserialize<_i68.StudySuggestion>(data['data']);
    }
    if (dataClassName == 'TimetableEntry') {
      return deserialize<_i69.TimetableEntry>(data['data']);
    }
    if (dataClassName == 'VectorCapabilityProbe') {
      return deserialize<_i70.VectorCapabilityProbe>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.AcademicYear:
        return _i6.AcademicYear.t;
      case _i7.AiConversation:
        return _i7.AiConversation.t;
      case _i8.AiMessage:
        return _i8.AiMessage.t;
      case _i9.AiUsage:
        return _i9.AiUsage.t;
      case _i10.AiUserMemory:
        return _i10.AiUserMemory.t;
      case _i11.Announcement:
        return _i11.Announcement.t;
      case _i13.AuditLog:
        return _i13.AuditLog.t;
      case _i17.BookCopy:
        return _i17.BookCopy.t;
      case _i21.BookLoan:
        return _i21.BookLoan.t;
      case _i26.CampusNotification:
        return _i26.CampusNotification.t;
      case _i28.Course:
        return _i28.Course.t;
      case _i30.CourseOffering:
        return _i30.CourseOffering.t;
      case _i31.CourseSchedule:
        return _i31.CourseSchedule.t;
      case _i37.Enrollment:
        return _i37.Enrollment.t;
      case _i38.ExamSchedule:
        return _i38.ExamSchedule.t;
      case _i40.FavoriteBook:
        return _i40.FavoriteBook.t;
      case _i41.GradeComponent:
        return _i41.GradeComponent.t;
      case _i45.LibraryAuthor:
        return _i45.LibraryAuthor.t;
      case _i46.LibraryBook:
        return _i46.LibraryBook.t;
      case _i47.LibraryBookAuthor:
        return _i47.LibraryBookAuthor.t;
      case _i48.LibraryBookCategory:
        return _i48.LibraryBookCategory.t;
      case _i49.LibraryBookCourse:
        return _i49.LibraryBookCourse.t;
      case _i50.LibraryBookFile:
        return _i50.LibraryBookFile.t;
      case _i51.LibraryCategory:
        return _i51.LibraryCategory.t;
      case _i58.ReaderBookmark:
        return _i58.ReaderBookmark.t;
      case _i59.ReaderHighlight:
        return _i59.ReaderHighlight.t;
      case _i60.ReaderNote:
        return _i60.ReaderNote.t;
      case _i61.ReadingProgress:
        return _i61.ReadingProgress.t;
      case _i63.Semester:
        return _i63.Semester.t;
      case _i65.StudentAiPreference:
        return _i65.StudentAiPreference.t;
      case _i66.StudentGrade:
        return _i66.StudentGrade.t;
      case _i67.StudentProfile:
        return _i67.StudentProfile.t;
      case _i70.VectorCapabilityProbe:
        return _i70.VectorCapabilityProbe.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'campusmate';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
