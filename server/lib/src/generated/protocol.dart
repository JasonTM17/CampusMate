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
import 'course.dart' as _i10;
import 'course_detail.dart' as _i11;
import 'course_offering.dart' as _i12;
import 'course_schedule.dart' as _i13;
import 'course_summary.dart' as _i14;
import 'curriculum_block_progress.dart' as _i15;
import 'curriculum_progress.dart' as _i16;
import 'enrollment.dart' as _i17;
import 'exam_schedule.dart' as _i18;
import 'exam_summary.dart' as _i19;
import 'grade_component.dart' as _i20;
import 'grade_component_score.dart' as _i21;
import 'grade_summary.dart' as _i22;
import 'greetings/greeting.dart' as _i23;
import 'semester.dart' as _i24;
import 'semester_summary.dart' as _i25;
import 'student_grade.dart' as _i26;
import 'student_profile.dart' as _i27;
import 'timetable_entry.dart' as _i28;
import 'vector_capability_probe.dart' as _i29;
import 'package:campusmate_server/src/generated/course_summary.dart' as _i30;
import 'package:campusmate_server/src/generated/timetable_entry.dart' as _i31;
import 'package:campusmate_server/src/generated/exam_summary.dart' as _i32;
import 'package:campusmate_server/src/generated/ai_conversations.dart' as _i33;
import 'package:campusmate_server/src/generated/ai_messages.dart' as _i34;
export 'academic_overview.dart';
export 'academic_year.dart';
export 'ai_conversations.dart';
export 'ai_messages.dart';
export 'ai_usage.dart';
export 'course.dart';
export 'course_detail.dart';
export 'course_offering.dart';
export 'course_schedule.dart';
export 'course_summary.dart';
export 'curriculum_block_progress.dart';
export 'curriculum_progress.dart';
export 'enrollment.dart';
export 'exam_schedule.dart';
export 'exam_summary.dart';
export 'grade_component.dart';
export 'grade_component_score.dart';
export 'grade_summary.dart';
export 'greetings/greeting.dart';
export 'semester.dart';
export 'semester_summary.dart';
export 'student_grade.dart';
export 'student_profile.dart';
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
    if (t == _i10.Course) {
      return _i10.Course.fromJson(data) as T;
    }
    if (t == _i11.CourseDetail) {
      return _i11.CourseDetail.fromJson(data) as T;
    }
    if (t == _i12.CourseOffering) {
      return _i12.CourseOffering.fromJson(data) as T;
    }
    if (t == _i13.CourseSchedule) {
      return _i13.CourseSchedule.fromJson(data) as T;
    }
    if (t == _i14.CourseSummary) {
      return _i14.CourseSummary.fromJson(data) as T;
    }
    if (t == _i15.CurriculumBlockProgress) {
      return _i15.CurriculumBlockProgress.fromJson(data) as T;
    }
    if (t == _i16.CurriculumProgress) {
      return _i16.CurriculumProgress.fromJson(data) as T;
    }
    if (t == _i17.Enrollment) {
      return _i17.Enrollment.fromJson(data) as T;
    }
    if (t == _i18.ExamSchedule) {
      return _i18.ExamSchedule.fromJson(data) as T;
    }
    if (t == _i19.ExamSummary) {
      return _i19.ExamSummary.fromJson(data) as T;
    }
    if (t == _i20.GradeComponent) {
      return _i20.GradeComponent.fromJson(data) as T;
    }
    if (t == _i21.GradeComponentScore) {
      return _i21.GradeComponentScore.fromJson(data) as T;
    }
    if (t == _i22.GradeSummary) {
      return _i22.GradeSummary.fromJson(data) as T;
    }
    if (t == _i23.Greeting) {
      return _i23.Greeting.fromJson(data) as T;
    }
    if (t == _i24.Semester) {
      return _i24.Semester.fromJson(data) as T;
    }
    if (t == _i25.SemesterSummary) {
      return _i25.SemesterSummary.fromJson(data) as T;
    }
    if (t == _i26.StudentGrade) {
      return _i26.StudentGrade.fromJson(data) as T;
    }
    if (t == _i27.StudentProfile) {
      return _i27.StudentProfile.fromJson(data) as T;
    }
    if (t == _i28.TimetableEntry) {
      return _i28.TimetableEntry.fromJson(data) as T;
    }
    if (t == _i29.VectorCapabilityProbe) {
      return _i29.VectorCapabilityProbe.fromJson(data) as T;
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
    if (t == _i1.getType<_i10.Course?>()) {
      return (data != null ? _i10.Course.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.CourseDetail?>()) {
      return (data != null ? _i11.CourseDetail.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.CourseOffering?>()) {
      return (data != null ? _i12.CourseOffering.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.CourseSchedule?>()) {
      return (data != null ? _i13.CourseSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.CourseSummary?>()) {
      return (data != null ? _i14.CourseSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.CurriculumBlockProgress?>()) {
      return (data != null ? _i15.CurriculumBlockProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.CurriculumProgress?>()) {
      return (data != null ? _i16.CurriculumProgress.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.Enrollment?>()) {
      return (data != null ? _i17.Enrollment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ExamSchedule?>()) {
      return (data != null ? _i18.ExamSchedule.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.ExamSummary?>()) {
      return (data != null ? _i19.ExamSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.GradeComponent?>()) {
      return (data != null ? _i20.GradeComponent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.GradeComponentScore?>()) {
      return (data != null ? _i21.GradeComponentScore.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.GradeSummary?>()) {
      return (data != null ? _i22.GradeSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Greeting?>()) {
      return (data != null ? _i23.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.Semester?>()) {
      return (data != null ? _i24.Semester.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.SemesterSummary?>()) {
      return (data != null ? _i25.SemesterSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.StudentGrade?>()) {
      return (data != null ? _i26.StudentGrade.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.StudentProfile?>()) {
      return (data != null ? _i27.StudentProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.TimetableEntry?>()) {
      return (data != null ? _i28.TimetableEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.VectorCapabilityProbe?>()) {
      return (data != null ? _i29.VectorCapabilityProbe.fromJson(data) : null)
          as T;
    }
    if (t == List<_i25.SemesterSummary>) {
      return (data as List)
              .map((e) => deserialize<_i25.SemesterSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i14.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i14.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i28.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i19.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i19.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i21.GradeComponentScore>) {
      return (data as List)
              .map((e) => deserialize<_i21.GradeComponentScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i15.CurriculumBlockProgress>) {
      return (data as List)
              .map((e) => deserialize<_i15.CurriculumBlockProgress>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.CourseSummary>) {
      return (data as List)
              .map((e) => deserialize<_i30.CourseSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.TimetableEntry>) {
      return (data as List)
              .map((e) => deserialize<_i31.TimetableEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.ExamSummary>) {
      return (data as List)
              .map((e) => deserialize<_i32.ExamSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.AiConversation>) {
      return (data as List)
              .map((e) => deserialize<_i33.AiConversation>(e))
              .toList()
          as T;
    }
    if (t == List<_i34.AiMessage>) {
      return (data as List).map((e) => deserialize<_i34.AiMessage>(e)).toList()
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
      _i10.Course => 'Course',
      _i11.CourseDetail => 'CourseDetail',
      _i12.CourseOffering => 'CourseOffering',
      _i13.CourseSchedule => 'CourseSchedule',
      _i14.CourseSummary => 'CourseSummary',
      _i15.CurriculumBlockProgress => 'CurriculumBlockProgress',
      _i16.CurriculumProgress => 'CurriculumProgress',
      _i17.Enrollment => 'Enrollment',
      _i18.ExamSchedule => 'ExamSchedule',
      _i19.ExamSummary => 'ExamSummary',
      _i20.GradeComponent => 'GradeComponent',
      _i21.GradeComponentScore => 'GradeComponentScore',
      _i22.GradeSummary => 'GradeSummary',
      _i23.Greeting => 'Greeting',
      _i24.Semester => 'Semester',
      _i25.SemesterSummary => 'SemesterSummary',
      _i26.StudentGrade => 'StudentGrade',
      _i27.StudentProfile => 'StudentProfile',
      _i28.TimetableEntry => 'TimetableEntry',
      _i29.VectorCapabilityProbe => 'VectorCapabilityProbe',
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
      case _i10.Course():
        return 'Course';
      case _i11.CourseDetail():
        return 'CourseDetail';
      case _i12.CourseOffering():
        return 'CourseOffering';
      case _i13.CourseSchedule():
        return 'CourseSchedule';
      case _i14.CourseSummary():
        return 'CourseSummary';
      case _i15.CurriculumBlockProgress():
        return 'CurriculumBlockProgress';
      case _i16.CurriculumProgress():
        return 'CurriculumProgress';
      case _i17.Enrollment():
        return 'Enrollment';
      case _i18.ExamSchedule():
        return 'ExamSchedule';
      case _i19.ExamSummary():
        return 'ExamSummary';
      case _i20.GradeComponent():
        return 'GradeComponent';
      case _i21.GradeComponentScore():
        return 'GradeComponentScore';
      case _i22.GradeSummary():
        return 'GradeSummary';
      case _i23.Greeting():
        return 'Greeting';
      case _i24.Semester():
        return 'Semester';
      case _i25.SemesterSummary():
        return 'SemesterSummary';
      case _i26.StudentGrade():
        return 'StudentGrade';
      case _i27.StudentProfile():
        return 'StudentProfile';
      case _i28.TimetableEntry():
        return 'TimetableEntry';
      case _i29.VectorCapabilityProbe():
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
    if (dataClassName == 'Course') {
      return deserialize<_i10.Course>(data['data']);
    }
    if (dataClassName == 'CourseDetail') {
      return deserialize<_i11.CourseDetail>(data['data']);
    }
    if (dataClassName == 'CourseOffering') {
      return deserialize<_i12.CourseOffering>(data['data']);
    }
    if (dataClassName == 'CourseSchedule') {
      return deserialize<_i13.CourseSchedule>(data['data']);
    }
    if (dataClassName == 'CourseSummary') {
      return deserialize<_i14.CourseSummary>(data['data']);
    }
    if (dataClassName == 'CurriculumBlockProgress') {
      return deserialize<_i15.CurriculumBlockProgress>(data['data']);
    }
    if (dataClassName == 'CurriculumProgress') {
      return deserialize<_i16.CurriculumProgress>(data['data']);
    }
    if (dataClassName == 'Enrollment') {
      return deserialize<_i17.Enrollment>(data['data']);
    }
    if (dataClassName == 'ExamSchedule') {
      return deserialize<_i18.ExamSchedule>(data['data']);
    }
    if (dataClassName == 'ExamSummary') {
      return deserialize<_i19.ExamSummary>(data['data']);
    }
    if (dataClassName == 'GradeComponent') {
      return deserialize<_i20.GradeComponent>(data['data']);
    }
    if (dataClassName == 'GradeComponentScore') {
      return deserialize<_i21.GradeComponentScore>(data['data']);
    }
    if (dataClassName == 'GradeSummary') {
      return deserialize<_i22.GradeSummary>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i23.Greeting>(data['data']);
    }
    if (dataClassName == 'Semester') {
      return deserialize<_i24.Semester>(data['data']);
    }
    if (dataClassName == 'SemesterSummary') {
      return deserialize<_i25.SemesterSummary>(data['data']);
    }
    if (dataClassName == 'StudentGrade') {
      return deserialize<_i26.StudentGrade>(data['data']);
    }
    if (dataClassName == 'StudentProfile') {
      return deserialize<_i27.StudentProfile>(data['data']);
    }
    if (dataClassName == 'TimetableEntry') {
      return deserialize<_i28.TimetableEntry>(data['data']);
    }
    if (dataClassName == 'VectorCapabilityProbe') {
      return deserialize<_i29.VectorCapabilityProbe>(data['data']);
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
      case _i10.Course:
        return _i10.Course.t;
      case _i12.CourseOffering:
        return _i12.CourseOffering.t;
      case _i13.CourseSchedule:
        return _i13.CourseSchedule.t;
      case _i17.Enrollment:
        return _i17.Enrollment.t;
      case _i18.ExamSchedule:
        return _i18.ExamSchedule.t;
      case _i20.GradeComponent:
        return _i20.GradeComponent.t;
      case _i24.Semester:
        return _i24.Semester.t;
      case _i26.StudentGrade:
        return _i26.StudentGrade.t;
      case _i27.StudentProfile:
        return _i27.StudentProfile.t;
      case _i29.VectorCapabilityProbe:
        return _i29.VectorCapabilityProbe.t;
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
