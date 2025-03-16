import 'package:flutter/material.dart';

class PremiumThemes {
  // Aurora Borealis theme (deep blues & neon greens)
  static final ThemeData auroraBorealisLightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E88E5),
      primary: const Color(0xFF1E88E5),
      secondary: const Color(0xFF00E676),
      tertiary: const Color(0xFF7C4DFF),
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF1E88E5),
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.blue.shade50,
    ),
  );

  static final ThemeData auroraBorealisDarkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E88E5),
      primary: const Color(0xFF1E88E5),
      secondary: const Color(0xFF00E676),
      tertiary: const Color(0xFF7C4DFF),
      brightness: Brightness.dark,
      background: const Color(0xFF0D1117),
      surface: const Color(0xFF1A1D24),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF0D1117),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF1A1D24),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: const Color(0xFF1A1D24),
    ),
  );

  // Zen Garden theme (earth tones, cherry blossom highlights)
  static final ThemeData zenGardenLightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF8BBD0), // Cherry blossom pink
      primary: const Color(0xFFF8BBD0),
      secondary: const Color(0xFF8D6E63), // Earth brown
      tertiary: const Color(0xFF81C784), // Leaf green
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFFF8BBD0),
      foregroundColor: Color(0xFF5D4037),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.pink.shade50,
    ),
  );

  static final ThemeData zenGardenDarkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF8BBD0),
      primary: const Color(0xFFF8BBD0),
      secondary: const Color(0xFF8D6E63),
      tertiary: const Color(0xFF81C784),
      brightness: Brightness.dark,
      background: const Color(0xFF2E2E2E),
      surface: const Color(0xFF3E3E3E),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF2E2E2E),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFF3E3E3E),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: const Color(0xFF3E3E3E),
    ),
  );

  // Midnight Gold theme (sleek black & gold)
  static final ThemeData midnightGoldLightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFD700), // Gold
      primary: const Color(0xFFFFD700),
      secondary: const Color(0xFF212121), // Near black
      tertiary: const Color(0xFFBDBDBD), // Silver
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFFFFD700),
      foregroundColor: Color(0xFF212121),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.yellow.shade50,
    ),
  );

  static final ThemeData midnightGoldDarkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFD700),
      primary: const Color(0xFFFFD700),
      secondary: const Color(0xFFBDBDBD),
      tertiary: const Color(0xFFE0E0E0),
      brightness: Brightness.dark,
      background: const Color(0xFF121212),
      surface: const Color(0xFF1E1E1E),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF121212),
    ),
    cardTheme: CardTheme(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: const Color(0xFF1E1E1E),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: const Color(0xFF1E1E1E),
    ),
  );

  // Minimal Frost theme (icy blues & whites)
  static final ThemeData minimalFrostLightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF90CAF9), // Light blue
      primary: const Color(0xFF90CAF9),
      secondary: const Color(0xFFE1F5FE), // Very light blue
      tertiary: const Color(0xFFFFFFFF), // White
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF90CAF9),
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.blue.shade50,
    ),
  );

  static final ThemeData minimalFrostDarkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF90CAF9),
      primary: const Color(0xFF90CAF9),
      secondary: const Color(0xFFE1F5FE),
      tertiary: const Color(0xFFFFFFFF),
      brightness: Brightness.dark,
      background: const Color(0xFF1A237E),
      surface: const Color(0xFF283593),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF1A237E),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFF283593),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: const Color(0xFF283593),
    ),
  );

  // Sunset Serenity theme (soft pink-orange gradients)
  static final ThemeData sunsetSerenityLightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFAB91), // Soft orange
      primary: const Color(0xFFFFAB91),
      secondary: const Color(0xFFF48FB1), // Soft pink
      tertiary: const Color(0xFFFFCC80), // Light orange
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFFFFAB91),
      foregroundColor: Colors.white,
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.orange.shade50,
    ),
  );

  static final ThemeData sunsetSerenityDarkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFAB91),
      primary: const Color(0xFFFFAB91),
      secondary: const Color(0xFFF48FB1),
      tertiary: const Color(0xFFFFCC80),
      brightness: Brightness.dark,
      background: const Color(0xFF3E2723),
      surface: const Color(0xFF4E342E),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Color(0xFF3E2723),
    ),
    cardTheme: CardTheme(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: const Color(0xFF4E342E),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: const Color(0xFF4E342E),
    ),
  );

  // Map of theme names to their ThemeData objects
  static Map<String, Map<String, ThemeData>> getAllThemes() {
    return {
      'auroraBorealis': {
        'light': auroraBorealisLightTheme,
        'dark': auroraBorealisDarkTheme,
      },
      'zenGarden': {'light': zenGardenLightTheme, 'dark': zenGardenDarkTheme},
      'midnightGold': {
        'light': midnightGoldLightTheme,
        'dark': midnightGoldDarkTheme,
      },
      'minimalFrost': {
        'light': minimalFrostLightTheme,
        'dark': minimalFrostDarkTheme,
      },
      'sunsetSerenity': {
        'light': sunsetSerenityLightTheme,
        'dark': sunsetSerenityDarkTheme,
      },
    };
  }

  // Get a specific theme by name and mode
  static ThemeData getTheme(String themeName, String mode) {
    final themes = getAllThemes();
    if (themes.containsKey(themeName) && themes[themeName]!.containsKey(mode)) {
      return themes[themeName]![mode]!;
    }
    // Return default theme if requested theme is not found
    return mode == 'dark' ? ThemeData.dark() : ThemeData.light();
  }
}
