import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum FocusModeType {
  pomodoro,
  deepWork,
  shortBreak,
  meditation,
  custom
}

enum BackgroundSoundType {
  rain,
  cafe,
  whitenoise,
  nature,
  binauralBeats,
  silence,
  custom
}

class FocusMode {
  final String id;
  final String userId;
  final String name;
  final String description;
  final FocusModeType type;
  final int workDurationMinutes;
  final int breakDurationMinutes;
  final int cycles;
  final BackgroundSoundType backgroundSound;
  final String? customSoundUrl;
  final bool isAdaptive;
  final Map<String, dynamic>? adaptiveSettings;
  final bool isPremiumOnly;
  final DateTime createdAt;
  final DateTime? lastUsedAt;

  FocusMode({
    String? id,
    required this.userId,
    required this.name,
    this.description = '',
    required this.type,
    required this.workDurationMinutes,
    required this.breakDurationMinutes,
    this.cycles = 4,
    this.backgroundSound = BackgroundSoundType.silence,
    this.customSoundUrl,
    this.isAdaptive = false,
    this.adaptiveSettings,
    this.isPremiumOnly = false,
    DateTime? createdAt,
    this.lastUsedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  FocusMode copyWith({
    String? name,
    String? description,
    FocusModeType? type,
    int? workDurationMinutes,
    int? breakDurationMinutes,
    int? cycles,
    BackgroundSoundType? backgroundSound,
    String? customSoundUrl,
    bool? isAdaptive,
    Map<String, dynamic>? adaptiveSettings,
    bool? isPremiumOnly,
    DateTime? lastUsedAt,
  }) {
    return FocusMode(
      id: id,
      userId: userId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      workDurationMinutes: workDurationMinutes ?? this.workDurationMinutes,
      breakDurationMinutes: breakDurationMinutes ?? this.breakDurationMinutes,
      cycles: cycles ?? this.cycles,
      backgroundSound: backgroundSound ?? this.backgroundSound,
      customSoundUrl: customSoundUrl ?? this.customSoundUrl,
      isAdaptive: isAdaptive ?? this.isAdaptive,
      adaptiveSettings: adaptiveSettings ?? this.adaptiveSettings,
      isPremiumOnly: isPremiumOnly ?? this.isPremiumOnly,
      createdAt: createdAt,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'type': type.toString().split('.').last,
      'workDurationMinutes': workDurationMinutes,
      'breakDurationMinutes': breakDurationMinutes,
      'cycles': cycles,
      'backgroundSound': backgroundSound.toString().split('.').last,
      'customSoundUrl': customSoundUrl,
      'isAdaptive': isAdaptive,
      'adaptiveSettings': adaptiveSettings,
      'isPremiumOnly': isPremiumOnly,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastUsedAt': lastUsedAt != null ? Timestamp.fromDate(lastUsedAt!) : null,
    };
  }

  factory FocusMode.fromMap(Map<String, dynamic> map) {
    return FocusMode(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      description: map['description'] ?? '',
      type: FocusModeType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => FocusModeType.pomodoro,
      ),
      workDurationMinutes: map['workDurationMinutes'],
      breakDurationMinutes: map['breakDurationMinutes'],
      cycles: map['cycles'] ?? 4,
      backgroundSound: BackgroundSoundType.values.firstWhere(
        (e) => e.toString().split('.').last == map['backgroundSound'],
        orElse: () => BackgroundSoundType.silence,
      ),
      customSoundUrl: map['customSoundUrl'],
      isAdaptive: map['isAdaptive'] ?? false,
      adaptiveSettings: map['adaptiveSettings'],
      isPremiumOnly: map['isPremiumOnly'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastUsedAt: map['lastUsedAt'] != null
          ? (map['lastUsedAt'] as Timestamp).toDate()
          : null,
    );
  }
}