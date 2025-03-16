import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a provider container for accessing providers outside of the widget tree
final providerContainer = ProviderContainer();

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

// Initialize theme from saved preferences
Future<void> initThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final savedThemeMode = prefs.getString('themeMode');

  if (savedThemeMode != null) {
    switch (savedThemeMode) {
      case 'light':
        providerContainer.read(themeModeProvider.notifier).state = ThemeMode.light;
        break;
      case 'dark':
        providerContainer.read(themeModeProvider.notifier).state = ThemeMode.dark;
        break;
      default:
        providerContainer.read(themeModeProvider.notifier).state = ThemeMode.system;
    }
  }
}

// Save theme preference when changed
void saveThemeMode(ThemeMode mode) async {
  final prefs = await SharedPreferences.getInstance();
  String themeValue;

  switch (mode) {
    case ThemeMode.light:
      themeValue = 'light';
      break;
    case ThemeMode.dark:
      themeValue = 'dark';
      break;
    default:
      themeValue = 'system';
  }

  await prefs.setString('themeMode', themeValue);

  // Update the provider state
  providerContainer.read(themeModeProvider.notifier).state = mode;
}
