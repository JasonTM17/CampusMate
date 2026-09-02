import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'features/chat/application/chat_controller.dart';
import 'features/chat/data/serverpod_ai_repository.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [
        aiRepositoryProvider.overrideWith(
          (ref) => ServerpodAiRepository(ref.watch(serverpodClientProvider)),
        ),
      ],
      child: const CampusMateApp(),
    ),
  );
}
