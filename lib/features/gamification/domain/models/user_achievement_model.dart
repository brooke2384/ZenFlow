import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum AchievementType {
  dailyStreak,
  taskCompletion,
  journalStreak,
  mindfulnessStreak,
  focusTime,
  challengeCompletion,
}

class UserAchievement {
  final String id;
  final String userId;
  final String title;
  final String description;
  final AchievementType type;
  final int level;
  final int currentProgress;
  final int targetProgress;
  final DateTime unlockedAt;
  final String? iconPath;
  final int xpAwarded;
  final bool isUnlocked;

  UserAchievement({
    String? id,
    required this.userId,
    required this.title,
    required this.description,
    required this.type,
    required this.level,
    required this.currentProgress,
    required this.targetProgress,
    DateTime? unlockedAt,
    this.iconPath,
    required this.xpAwarded,
    this.isUnlocked = false,
  }) : id = id ?? const Uuid().v4(),
       unlockedAt = unlockedAt ?? DateTime.now();

  UserAchievement copyWith({
    String? title,
    String? description,
    AchievementType? type,
    int? level,
    int? currentProgress,
    int? targetProgress,
    String? iconPath,
    int? xpAwarded,
    bool? isUnlocked,
  }) {
    return UserAchievement(
      id: id,
      userId: userId,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      level: level ?? this.level,
      currentProgress: currentProgress ?? this.currentProgress,
      targetProgress: targetProgress ?? this.targetProgress,
      unlockedAt:
          isUnlocked == true && this.isUnlocked == false
              ? DateTime.now()
              : unlockedAt,
      iconPath: iconPath ?? this.iconPath,
      xpAwarded: xpAwarded ?? this.xpAwarded,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'level': level,
      'currentProgress': currentProgress,
      'targetProgress': targetProgress,
      'unlockedAt': isUnlocked ? Timestamp.fromDate(unlockedAt) : null,
      'iconPath': iconPath,
      'xpAwarded': xpAwarded,
      'isUnlocked': isUnlocked,
    };
  }

  factory UserAchievement.fromMap(Map<String, dynamic> map) {
    return UserAchievement(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
      type: AchievementType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => AchievementType.dailyStreak,
      ),
      level: map['level'],
      currentProgress: map['currentProgress'],
      targetProgress: map['targetProgress'],
      unlockedAt:
          map['unlockedAt'] != null
              ? (map['unlockedAt'] as Timestamp).toDate()
              : null,
      iconPath: map['iconPath'],
      xpAwarded: map['xpAwarded'],
      isUnlocked: map['isUnlocked'] ?? false,
    );
  }
}
