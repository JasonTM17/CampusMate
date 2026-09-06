# CampusMate Mobile

Flutter client for CampusMate, focused on student workflows, e-library access,
and the personalized AI chat experience.

## Run Locally

```bash
flutter pub get
flutter run -d <device>
```

On Android emulator, the app defaults to `http://10.0.2.2:8080/`. For a real
device or a non-default server port, pass:

```bash
flutter run \
  --dart-define=CAMPUSMATE_SERVER_URL=http://<server-host>:8080/ \
  -d <device>
```

## Verification

```bash
dart format --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build apk --debug
```

Live backend spike tests stay skipped unless `CAMPUSMATE_LIVE_SPIKE=1` is set
and a compatible Serverpod backend is already running.
