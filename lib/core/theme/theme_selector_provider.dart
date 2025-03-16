import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenflow/core/theme/premium_themes.dart';
import 'package:zenflow/core/theme/theme_provider.dart';

// Provider for the selected theme name
final selectedThemeNameProvider = StateProvider<String>((ref) {
  return 'default'; // Default system theme
});

// Provider that returns the current ThemeData based on theme mode and selected theme
final currentThemeProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  final themeName = ref.watch(selectedThemeNameProvider);

  // If using default theme
  if (themeName == 'default') {
    switch (themeMode) {
      case ThemeMode.light:
        return ThemeData.light();
      case ThemeMode.dark:
        return ThemeData.dark();
      default:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark
            ? ThemeData.dark()
            : ThemeData.light();
    }
  }

  // Using premium theme
  final mode =
      themeMode == ThemeMode.dark ||
              (themeMode == ThemeMode.system &&
                  WidgetsBinding
                          .instance
                          .platformDispatcher
                          .platformBrightness ==
                      Brightness.dark)
          ? 'dark'
          : 'light';

  return PremiumThemes.getTheme(themeName, mode);
});

// Initialize theme name from saved preferences
Future<void> initThemeName() async {
  final prefs = await SharedPreferences.getInstance();
  final savedThemeName = prefs.getString('themeName');

  if (savedThemeName != null) {
    providerContainer.read(selectedThemeNameProvider.notifier).state =
        savedThemeName;
  }
}

// Save theme name preference when changed
void saveThemeName(String themeName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('themeName', themeName);

  // Update the provider state
  providerContainer.read(selectedThemeNameProvider.notifier).state = themeName;
}

// Check if a theme is premium-only
bool isPremiumTheme(String themeName) {
  // All themes except default are premium
  return themeName != 'default';
}
