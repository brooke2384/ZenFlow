import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String userId;
  final int xpPoints;
  final int level;
  final int dailyStreak;
  final int journalStreak;
  final int mindfulnessStreak;
  final int tasksCompleted;
  final int challengesCompleted;
  final int focusMinutes;
  final bool isPremium;
  final String? selectedTheme;
  final DateTime lastActive;
  final Map<String, dynamic>? preferences;

  UserProfile({
    required this.userId,
    this.xpPoints = 0,
    this.level = 1,
    this.dailyStreak = 0,
    this.journalStreak = 0,
    this.mindfulnessStreak = 0,
    this.tasksCompleted = 0,
    this.challengesCompleted = 0,
    this.focusMinutes = 0,
    this.isPremium = false,
    this.selectedTheme,
    DateTime? lastActive,
    this.preferences,
  }) : lastActive = lastActive ?? DateTime.now();

  UserProfile copyWith({
    int? xpPoints,
    int? level,
    int? dailyStreak,
    int? journalStreak,
    int? mindfulnessStreak,
    int? tasksCompleted,
    int? challengesCompleted,
    int? focusMinutes,
    bool? isPremium,
    String? selectedTheme,
    DateTime? lastActive,
    Map<String, dynamic>? preferences,
  }) {
    return UserProfile(
      userId: userId,
      xpPoints: xpPoints ?? this.xpPoints,
      level: level ?? this.level,
      dailyStreak: dailyStreak ?? this.dailyStreak,
      journalStreak: journalStreak ?? this.journalStreak,
      mindfulnessStreak: mindfulnessStreak ?? this.mindfulnessStreak,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      challengesCompleted: challengesCompleted ?? this.challengesCompleted,
      focusMinutes: focusMinutes ?? this.focusMinutes,
      isPremium: isPremium ?? this.isPremium,
      selectedTheme: selectedTheme ?? this.selectedTheme,
      lastActive: lastActive ?? this.lastActive,
      preferences: preferences ?? this.preferences,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'xpPoints': xpPoints,
      'level': level,
      'dailyStreak': dailyStreak,
      'journalStreak': journalStreak,
      'mindfulnessStreak': mindfulnessStreak,
      'tasksCompleted': tasksCompleted,
      'challengesCompleted': challengesCompleted,
      'focusMinutes': focusMinutes,
      'isPremium': isPremium,
      'selectedTheme': selectedTheme,
      'lastActive': Timestamp.fromDate(lastActive),
      'preferences': preferences,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      userId: map['userId'],
      xpPoints: map['xpPoints'] ?? 0,
      level: map['level'] ?? 1,
      dailyStreak: map['dailyStreak'] ?? 0,
      journalStreak: map['journalStreak'] ?? 0,
      mindfulnessStreak: map['mindfulnessStreak'] ?? 0,
      tasksCompleted: map['tasksCompleted'] ?? 0,
      challengesCompleted: map['challengesCompleted'] ?? 0,
      focusMinutes: map['focusMinutes'] ?? 0,
      isPremium: map['isPremium'] ?? false,
      selectedTheme: map['selectedTheme'],
      lastActive:
          map['lastActive'] != null
              ? (map['lastActive'] as Timestamp).toDate()
              : DateTime.now(),
      preferences: map['preferences'],
    );
  }
}
