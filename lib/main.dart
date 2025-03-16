import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zenflow/core/routes/app_router.dart';
import 'package:zenflow/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: ZenFlowApp()));
}

class ZenFlowApp extends ConsumerWidget {
  const ZenFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'ZenFlow',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
