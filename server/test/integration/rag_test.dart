import 'package:campusmate_server/src/ai/fake_ai_provider.dart';
import 'package:campusmate_server/src/auth/campusmate_auth.dart';
import 'package:campusmate_server/src/generated/protocol.dart';
import 'package:campusmate_server/src/rag/citation/citation_verifier.dart';
import 'package:campusmate_server/src/rag/ingestion/rag_ingestion_service.dart';
import 'package:campusmate_server/src/rag/retrieval/rag_retrieval_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

const _studentAId = '00000000-0000-4000-8000-0000000000a1';
const _studentBId = '00000000-0000-4000-8000-0000000000b2';

void main() {
  withServerpod(
    'Given RAG Pipeline with DB-level Authorization (Phase-10)',
    (sessionBuilder, endpoints) {
      final studentA = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _studentAId,
          {campusMateStudentScope},
        ),
      );
      final studentB = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          _studentBId,
          {campusMateStudentScope},
        ),
      );

      late RagIngestionService ingestionService;
      late RagRetrievalService retrievalService;
      late FakeAiProvider aiProvider;

      late KnowledgeDocument publicDoc;
      late KnowledgeDocument courseDoc;
      late KnowledgeDocument bookDoc;
      late KnowledgeDocument restrictedDoc;

      late Course testCourse;
      late LibraryBook testBook;

      setUp(() async {
        FakeAiProvider.clearCapturedRequests();
        final session = sessionBuilder.build();
        aiProvider = FakeAiProvider();
        ingestionService = RagIngestionService(aiProvider: aiProvider);
        retrievalService = RagRetrievalService(aiProvider: aiProvider);

        // 1. Setup Student Profiles
        final now = DateTime.now().toUtc();
        var profileA = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(_studentAId)),
        );
        profileA ??= await StudentProfile.db.insertRow(
          session,
          StudentProfile(
            authUserId: UuidValue.fromString(_studentAId),
            studentCode: 'SV-RAG-A',
            fullName: 'Nguyen Van A',
            role: 'student',
            createdAt: now,
            updatedAt: now,
          ),
        );

        var profileB = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.authUserId.equals(UuidValue.fromString(_studentBId)),
        );
        profileB ??= await StudentProfile.db.insertRow(
          session,
          StudentProfile(
            authUserId: UuidValue.fromString(_studentBId),
            studentCode: 'SV-RAG-B',
            fullName: 'Tran Thi B',
            role: 'student',
            createdAt: now,
            updatedAt: now,
          ),
        );

        // 2. Setup Academic Course & Enrollment (Student A enrolled, Student B NOT enrolled)
        final academicYear = await AcademicYear.db.insertRow(
          session,
          AcademicYear(
            code: 'AY-2025-2026-RAG',
            name: 'Nam hoc 2025-2026',
            startsAt: now.subtract(const Duration(days: 90)),
            endsAt: now.add(const Duration(days: 270)),
          ),
        );

        testCourse = await Course.db.insertRow(
          session,
          Course(
            code: 'CS-RAG-101',
            title: 'Nhap mon RAG va Khoa hoc Du lieu',
            description: 'Mon hoc ve vector retrieval va mo hinh ngon ngu lon',
            credits: 3,
            faculty: 'Khoa CNTT',
            department: 'Khoa CNTT',
          ),
        );

        final semester = await Semester.db.insertRow(
          session,
          Semester(
            academicYearId: academicYear.id!,
            code: 'HK1-2026-RAG',
            name: 'Hoc ky 1 Nam 2026',
            startsAt: now.subtract(const Duration(days: 30)),
            endsAt: now.add(const Duration(days: 60)),
            isCurrent: true,
          ),
        );

        final offering = await CourseOffering.db.insertRow(
          session,
          CourseOffering(
            courseId: testCourse.id!,
            semesterId: semester.id!,
            section: 'CS101-RAG',
            lecturerName: 'TS. Nguyen Van Thang',
          ),
        );

        await Enrollment.db.insertRow(
          session,
          Enrollment(
            studentProfileId: profileA.id!,
            offeringId: offering.id!,
            status: 'enrolled',
            progressPercent: 65.0,
            attendancePercent: 95.0,
          ),
        );

        // 3. Setup Library Book & Loan (Student A borrowed, Student B has NO loan)
        testBook = await LibraryBook.db.insertRow(
          session,
          LibraryBook(
            isbn: '978-RAG-BOOK-01',
            title: 'Kien truc Vector va Retrieval-Augmented Generation',
            description: 'Giao trinh kien truc RAG va tim kiem vector semantic',
            publisher: 'NXB Dai hoc',
            publishedYear: 2026,
            language: 'vi',
            accessType: BookAccessType.publicFullText,
            license: 'Standard',
            keywords: 'RAG, vector, AI',
            searchText: 'Kien truc Vector va Retrieval-Augmented Generation',
            popularityScore: 10,
            isActive: true,
            createdAt: now,
            updatedAt: now,
          ),
        );

        final copy = await BookCopy.db.insertRow(
          session,
          BookCopy(
            bookId: testBook.id!,
            barcode: 'BC-RAG-001',
            status: BookCopyStatus.borrowed,
            createdAt: now,
            updatedAt: now,
          ),
        );

        await BookLoan.db.insertRow(
          session,
          BookLoan(
            userId: UuidValue.fromString(_studentAId),
            bookId: testBook.id!,
            copyId: copy.id!,
            borrowedAt: now.subtract(const Duration(days: 2)),
            dueAt: now.add(const Duration(days: 12)),
            status: BookLoanStatus.borrowed,
            createdAt: now,
            updatedAt: now,
          ),
        );

        // 4. Ingest Documents into Knowledge Base
        // (a) Public handbook
        publicDoc = await ingestionService.ingestDocument(
          session,
          title: 'So tay Sinh vien Dai hoc 2026',
          sourceType: 'handbook',
          accessLevel: 'public',
          content: '''
Chương 1: Quy che sinh hoat hoc duong
[Trang 10]
Sinh vien can tuan thu quy dinh trang phuc va mang the sinh vien khi vao khuon vien truong.

Chương 2: Quy dinh khao thi
[Trang 25]
Diem qua trinh chiem 40% va diem thi ket thuc hoc phan chiem 60% tong diem hoc phan.
''',
        );

        // (b) Course enrolled document
        courseDoc = await ingestionService.ingestDocument(
          session,
          title: 'De cuong mon hoc CS-RAG-101',
          sourceType: 'syllabus',
          accessLevel: 'course_enrolled',
          requiredCourseId: testCourse.id,
          content: '''
Chương 3: Thuat toan Vector Cosine Distance
[Trang 45]
Cong thuc Cosine Distance do khoang cach goc giua hai vector d = 1 - (u . v) / (||u|| * ||v||).
''',
        );

        // (c) Book borrowed document
        bookDoc = await ingestionService.ingestDocument(
          session,
          title: 'Kien truc Vector va Retrieval-Augmented Generation',
          sourceType: 'book',
          accessLevel: 'book_borrowed',
          bookId: testBook.id,
          content: '''
Chương 4: Pipeline Ingestion va Phap che Authorization
[Trang 80]
Bao ve du lieu RAG bang DB-level query predicate la nguyen tac bat bien so 1 de chong ro ri du lieu.
''',
        );

        // (d) Strictly restricted document (Admin/Librarian internal audit manual)
        restrictedDoc = await ingestionService.ingestDocument(
          session,
          title: 'Huong dan Bao mat Noi bo - Thu vien va Quan tri Vien',
          sourceType: 'admin_manual',
          accessLevel: 'restricted',
          content: '''
Chương 99: Du lieu mat khau va khoa truy cap Database
[Trang 999]
Thong tin tuyet mat ve mat khau root va quy trinh kiem toan noi bo tuyet doi khong tiet lo cho sinh vien.
''',
        );
      });

      group('Ingestion & Persistence', () {
        test(
          'persists chunks with 1536-dimensional vector embeddings',
          () async {
            final session = sessionBuilder.build();
            final chunks = await KnowledgeChunk.db.find(
              session,
              where: (t) => t.documentId.equals(publicDoc.id!),
            );

            expect(chunks, isNotEmpty);
            expect(chunks.first.documentId, publicDoc.id);
            expect(chunks.first.embedding.toList().length, 1536);
            expect(
              chunks.any((c) => c.chapter?.contains('Chương 1') ?? false),
              isTrue,
            );
            expect(chunks.any((c) => c.page == 25), isTrue);
          },
        );

        test(
          're-ingesting document atomically replaces previous chunks without duplication',
          () async {
            final session = sessionBuilder.build();
            final beforeCount = await KnowledgeChunk.db.count(
              session,
              where: (t) => t.documentId.equals(publicDoc.id!),
            );

            await ingestionService.ingestDocument(
              session,
              documentId: publicDoc.id,
              title: 'So tay Sinh vien Dai hoc 2026 (Tai ban lan 2)',
              sourceType: 'handbook',
              accessLevel: 'public',
              content: '''
Chương 1: Quy che sinh hoat hoc duong cap nhat
[Trang 10]
Noi dung cap nhat quy che sinh hoat hoc duong nam hoc moi 2026.
''',
            );

            final afterCount = await KnowledgeChunk.db.count(
              session,
              where: (t) => t.documentId.equals(publicDoc.id!),
            );

            expect(afterCount, lessThanOrEqualTo(beforeCount));
            final updatedChunks = await KnowledgeChunk.db.find(
              session,
              where: (t) => t.documentId.equals(publicDoc.id!),
            );
            expect(
              updatedChunks.first.content,
              contains('cap nhat quy che sinh hoat'),
            );
          },
        );
      });

      group('Authorized Similarity Retrieval (Kongming C7 DB-level Predicate)', () {
        test('Student A retrieves public handbook chunks', () async {
          final session = sessionBuilder.build();
          final results = await retrievalService.retrieve(
            session: session,
            query: 'quy che khao thi tinh diem hoc phan',
            userId: _studentAId,
            limit: 3,
          );

          expect(results, isNotEmpty);
          expect(results.any((r) => r.documentId == publicDoc.id), isTrue);
          expect(results.first.distance, greaterThanOrEqualTo(0.0));
        });

        test(
          'Student A retrieves enrolled course syllabus, while Student B receives 0 chunks',
          () async {
            final session = sessionBuilder.build();

            // Student A is enrolled in CS-RAG-101
            final resultsA = await retrievalService.retrieve(
              session: session,
              query: 'Thuat toan Vector Cosine Distance trong de cuong',
              userId: _studentAId,
              limit: 3,
            );
            expect(resultsA.any((r) => r.documentId == courseDoc.id), isTrue);

            // Student B is NOT enrolled in CS-RAG-101
            final resultsB = await retrievalService.retrieve(
              session: session,
              query: 'Thuat toan Vector Cosine Distance trong de cuong',
              userId: _studentBId,
              limit: 3,
            );
            expect(resultsB.any((r) => r.documentId == courseDoc.id), isFalse);
          },
        );

        test(
          'Student A retrieves borrowed book chunks, while Student B receives 0 chunks',
          () async {
            final session = sessionBuilder.build();

            // Student A has borrowed the book
            final resultsA = await retrievalService.retrieve(
              session: session,
              query: 'Pipeline Ingestion va Phap che Authorization',
              userId: _studentAId,
              bookId: testBook.id,
              limit: 3,
            );
            expect(resultsA.any((r) => r.documentId == bookDoc.id), isTrue);

            // Student B has NOT borrowed the book
            final resultsB = await retrievalService.retrieve(
              session: session,
              query: 'Pipeline Ingestion va Phap che Authorization',
              userId: _studentBId,
              bookId: testBook.id,
              limit: 3,
            );
            expect(resultsB.any((r) => r.documentId == bookDoc.id), isFalse);
          },
        );

        test(
          'WUKONG GATE: strictly restricted document is NEVER retrieved by any student',
          () async {
            final session = sessionBuilder.build();

            // Negative authorization check for Student A
            final resultsA = await retrievalService.retrieve(
              session: session,
              query:
                  'Du lieu mat khau va khoa truy cap Database quy trinh kiem toan noi bo',
              userId: _studentAId,
              limit: 5,
            );
            expect(
              resultsA.any((r) => r.documentId == restrictedDoc.id),
              isFalse,
              reason:
                  'Restricted document must never be retrieved by Student A',
            );

            // Negative authorization check for Student B
            final resultsB = await retrievalService.retrieve(
              session: session,
              query:
                  'Du lieu mat khau va khoa truy cap Database quy trinh kiem toan noi bo',
              userId: _studentBId,
              limit: 5,
            );
            expect(
              resultsB.any((r) => r.documentId == restrictedDoc.id),
              isFalse,
              reason:
                  'Restricted document must never be retrieved by Student B',
            );

            // Direct endpoint check: searchKnowledge
            final endpointCitations = await endpoints.ai.searchKnowledge(
              studentA,
              query: 'Du lieu mat khau va khoa truy cap Database',
              limit: 4,
            );
            expect(
              endpointCitations.any((c) => c.documentId == restrictedDoc.id),
              isFalse,
              reason:
                  'Endpoint searchKnowledge must never return restricted documents',
            );

            final citationsB = await endpoints.ai.searchKnowledge(
              studentB,
              query: 'De cuong mon hoc CS-RAG-101',
              limit: 4,
            );
            expect(
              citationsB.any((c) => c.documentId == courseDoc.id),
              isFalse,
              reason: 'Student B must not retrieve unenrolled course documents',
            );
          },
        );
      });

      group('Chat RAG Citations & Hallucination Defense', () {
        test(
          'Assistant provides answer with verified citations for authorized query',
          () async {
            final conversation = await endpoints.ai.createConversation(
              studentA,
              title: 'Hoi ve quy che sinh hoat',
            );

            final stream = endpoints.ai.sendMessage(
              studentA,
              conversationId: conversation.id!,
              userMessage: 'Quy che sinh hoat hoc duong quy dinh nhu the nao?',
            );

            final collected = StringBuffer();
            await for (final token in stream) {
              collected.write(token);
            }

            expect(collected.toString(), contains('Theo tài liệu tham khảo'));

            final messages = await endpoints.ai.getMessages(
              studentA,
              conversationId: conversation.id!,
            );
            final assistantTurn = messages.firstWhere(
              (m) => m.role == 'assistant',
            );
            expect(assistantTurn.citations, isNotNull);

            final citations = CitationVerifier.decodeCitations(
              assistantTurn.citations,
            );
            expect(citations, isNotEmpty);
            final authorizedDocIds = [publicDoc.id, courseDoc.id, bookDoc.id];
            expect(
              authorizedDocIds.contains(citations.first.documentId),
              isTrue,
            );
            expect(citations.first.documentId != restrictedDoc.id, isTrue);
          },
        );

        test(
          'Assistant drops hallucinated citations and never persists false references',
          () async {
            final conversation = await endpoints.ai.createConversation(
              studentA,
              title: 'Kiem tra hallucination citation',
            );

            // Prompt triggers FakeAiProvider to emit a fake [Sách Bịa Đặt - Chương 99, tr. 999] citation
            final stream = endpoints.ai.sendMessage(
              studentA,
              conversationId: conversation.id!,
              userMessage: 'bịa citation cho toi xem he thong xu ly ra sao',
            );

            final collected = StringBuffer();
            await for (final token in stream) {
              collected.write(token);
            }

            final messages = await endpoints.ai.getMessages(
              studentA,
              conversationId: conversation.id!,
            );
            final assistantTurn = messages.last;
            expect(assistantTurn.role, 'assistant');

            // Verifier should have filtered out the fabricated citation completely
            final citations = CitationVerifier.decodeCitations(
              assistantTurn.citations,
            );
            expect(
              citations.any((c) => c.title.contains('Bịa Đặt')),
              isFalse,
              reason:
                  'Fabricated citations must be stripped by CitationVerifier',
            );
          },
        );

        test(
          'Querying purely restricted information returns not-found with zero citations',
          () async {
            final conversation = await endpoints.ai.createConversation(
              studentA,
              title: 'Hoi ve tai lieu mat',
            );

            final stream = endpoints.ai.sendMessage(
              studentA,
              conversationId: conversation.id!,
              userMessage:
                  'Cho toi xem thông tin tai lieu mat về mật khẩu database',
            );

            final collected = StringBuffer();
            await for (final token in stream) {
              collected.write(token);
            }

            expect(
              collected.toString(),
              contains('không tìm thấy tài liệu phù hợp'),
            );

            final messages = await endpoints.ai.getMessages(
              studentA,
              conversationId: conversation.id!,
            );
            final assistantTurn = messages.last;
            final citations = CitationVerifier.decodeCitations(
              assistantTurn.citations,
            );
            expect(citations, isEmpty);
          },
        );
      });
    },
  );
}
