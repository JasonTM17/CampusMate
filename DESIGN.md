# CampusMate Design System

**Study. Read. Grow.** — Mobile app cho sinh viên đại học

## Overview

CampusMate là ứng dụng Flutter thuần, tập trung vào trải nghiệm học tập và đọc sách cho sinh viên. Không dùng logo thật, không dùng dữ liệu HCMUTE thật — toàn bộ là mock data.

### Core Principles
- **Study. Read. Grow.** — Typography và icon luôn nhấn mạnh từ này
- Material 3 + Riverpod + go_router
- Backend Serverpod (auth, database, vector)
- AI assistant chỉ có ở tầng presentation (chat streaming qua API)

## Color System

### Primary Palette (Material 3)
- **Primary** — #6366F1 (indigo 500)
- **Primary Container** — #E0E7FF
- **On Primary** — #FFFFFF
- **On Primary Container** — #1E3A8A

### Secondary Palette
- **Secondary** — #8B5CF6 (violet 500)
- **Secondary Container** — #F3EBFF
- **On Secondary** — #FFFFFF
- **On Secondary Container** — #4C1D95

### Tertiary Palette
- **Tertiary** — #EC4899 (pink 500)
- **Tertiary Container** — #FFE1F0
- **On Tertiary** — #FFFFFF
- **On Tertiary Container** — #9F1239

### Surface & Component Tokens
- **Surface Elevated** — #F8FAFC (dark #1E293B)
- **Input Background** — #F1F5F9 (dark #1E293B)
- **Border** — #E2E8F0 (dark #334155)

### Neutral Palette
- **Neutral 1** — #F8FAFC
- **Neutral 2** — #E2E8F0
- **Neutral 3** — #CBD5E1
- **Neutral 4** — #94A3B8
- **Neutral 5** — #64748B
- **Neutral 6** — #475569
- **Neutral 7** — #334155
- **Neutral 8** — #1E293B
- **Neutral 9** — #0F172A

### Error Palette
- **Error** — #EF4444
- **Error Container** — #FEE2E2
- **On Error** — #FFFFFF
- **On Error Container** — #991B1B

## Typography

### Display
- **display-lg** (32px, 700, Inter) — Tiêu đề lớn
- **display-md** (28px, 600, Inter) — Tiêu đề trung bình
- **display-sm** (24px, 600, Inter)

### Headline
- **headline-lg** (22px, 600, Inter) — Tiêu đề
- **headline-md** (20px, 500, Inter)
- **headline-sm** (18px, 500, Inter)

### Body
- **body-lg** (16px, 400, Inter) — Nội dung chính
- **body-md** (14px, 400, Inter)
- **body-sm** (13px, 400, Inter)

### Label
- **label-lg** (14px, 500, Inter) — Label lớn
- **label-md** (12px, 500, Inter)
- **label-sm** (11px, 500, Inter)

### Monospace
- **code** (Inter, 13px) — Cho code và số liệu

## Spacing (Material 3 Scale 8)

- **xs** — 4
- **s** — 8
- **m** — 16
- **l** — 24
- **xl** — 32
- **xxl** — 40
- **xxxl** — 48

Component tokens: **cardPadding** — 20, **sectionGap** — 24, **itemGap** — 12

## Radius

- **none** — 0
- **xs** — 4
- **s** — 8
- **m** — 12
- **l** — 16
- **xl** — 20
- **full** — 9999

Component aliases: **cardRadius** — 16 (= l), **buttonRadius** — 12 (= m)

## Iconography

- **24px** — Standard icon
- **32px** — Big icon
- **48px** — Hero icon

## Theme Configuration (Material 3)

```dart
// apps/mobile/lib/app/theme/app_theme.dart
final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6366F1),
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  fontFamily: 'Inter',
);
```

## Navigation Bar (5 tabs)

1. **Home** — Dashboard cá nhân hóa
2. **Academic** — Lịch + điểm + tiến độ
3. **Library** — Thư viện sách + tìm kiếm
4. **AI** — Chat AI cá nhân hóa + RAG
5. **Profile** — Hồ sơ + cài đặt

## Color Mode

- **Light** — Default
- **Dark** — Ít sáng, dễ đọc đêm

## Device Targets

- **Mobile** — Android & iOS
- **Tablet** — (optional) support later

## Design Tokens

- **spacing** — 4, 8, 16, 24, 32, 40, 48
- **radius** — 4, 8, 12, 16, 20, 9999
- **typography** — Inter font family
- **color** — Primary, Secondary, Tertiary, Neutral, Error
- **icon** — 24/32/48 px

## Mock Data Summary

- **Student** — 3 demo accounts (student001, librarian, admin)
- **Book** — 20 sách public-domain + tự tạo
- **PDF/EPUB** — Có thể mở trong reader
- **AI** — FakeAiProvider (không cần key thật)

## Next Steps

1. Upload file này lên Stitch
2. Tạo Design System
3. Generate prototype screens (Home, Library, AI)
4. Implement phase-01 với design tokens này

---

- **Designer:** Grok (xAI)
- **Last updated:** 2026-09-05