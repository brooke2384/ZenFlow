import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:zenflow/core/routes/app_router.dart';
import 'package:zenflow/core/theme/app_theme.dart';
import 'package:zenflow/core/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenflow/core/theme/theme_selector_provider.dart';
import 'package:zenflow/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize theme from saved preferences before running the app
  await initThemeMode();
  
  runApp(ProviderScope(parent: providerContainer, child: const ZenFlowApp()));
}

class ZenFlowApp extends ConsumerWidget {
  const ZenFlowApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final selectedTheme = ref.watch(selectedThemeNameProvider);
    
    // Use default themes or premium themes based on selection
    final ThemeData lightTheme = selectedTheme == 'default' 
        ? AppTheme.lightTheme 
        : ref.watch(currentThemeProvider);
    final ThemeData darkTheme = selectedTheme == 'default'
        ? AppTheme.darkTheme
        : ref.watch(currentThemeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'ZenFlow',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      routerConfig: appRouter,
    );
  }
}
