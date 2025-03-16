// This is a basic Flutter widget test for ZenFlow app.
//
// This test verifies that the app can be initialized and rendered without errors.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenflow/main.dart';
import 'package:zenflow/core/theme/theme_provider.dart';

// Mock for Firebase and SharedPreferences
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenflow/firebase_options.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Mock the MethodChannel for Firebase
    const MethodChannel channel = MethodChannel(
      'plugins.flutter.io/firebase_core',
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'Firebase#initializeCore') {
            return [
              {
                'name': 'testApp',
                'options': {
                  'apiKey': 'mock-api-key',
                  'appId': 'mock-app-id',
                  'messagingSenderId': 'mock-sender-id',
                  'projectId': 'mock-project-id',
                },
                'pluginConstants': {},
              },
            ];
          }
          if (methodCall.method == 'Firebase#initializeApp') {
            return {
              'name': methodCall.arguments['appName'],
              'options': methodCall.arguments['options'],
              'pluginConstants': {},
            };
          }
          return null;
        });

    // Mock SharedPreferences for theme provider
    SharedPreferences.setMockInitialValues({'themeMode': 'system'});

    // Initialize mock Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  testWidgets('ZenFlow app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(child: const ZenFlowApp()));

    // Verify that the app renders without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
