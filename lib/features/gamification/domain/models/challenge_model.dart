import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum ChallengeType {
  mindfulness,
  productivity,
  journaling,
  social,
  focus,
  custom,
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final ChallengeType type;
  final int xpReward;
  final DateTime startDate;
  final DateTime endDate;
  final int targetGoal;
  final String? iconPath;
  final bool isGroupChallenge;
  final List<String> participantIds;
  final String creatorId;
  final Map<String, int> participantProgress;
  final bool isPremiumOnly;

  Challenge({
    String? id,
    required this.title,
    required this.description,
    required this.type,
    required this.xpReward,
    required this.startDate,
    required this.endDate,
    required this.targetGoal,
    this.iconPath,
    this.isGroupChallenge = false,
    List<String>? participantIds,
    required this.creatorId,
    Map<String, int>? participantProgress,
    this.isPremiumOnly = false,
  }) : id = id ?? const Uuid().v4(),
       participantIds = participantIds ?? [],
       participantProgress = participantProgress ?? {};

  Challenge copyWith({
    String? title,
    String? description,
    ChallengeType? type,
    int? xpReward,
    DateTime? startDate,
    DateTime? endDate,
    int? targetGoal,
    String? iconPath,
    bool? isGroupChallenge,
    List<String>? participantIds,
    Map<String, int>? participantProgress,
    bool? isPremiumOnly,
  }) {
    return Challenge(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      xpReward: xpReward ?? this.xpReward,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      targetGoal: targetGoal ?? this.targetGoal,
      iconPath: iconPath ?? this.iconPath,
      isGroupChallenge: isGroupChallenge ?? this.isGroupChallenge,
      participantIds: participantIds ?? this.participantIds,
      creatorId: creatorId,
      participantProgress: participantProgress ?? this.participantProgress,
      isPremiumOnly: isPremiumOnly ?? this.isPremiumOnly,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'xpReward': xpReward,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'targetGoal': targetGoal,
      'iconPath': iconPath,
      'isGroupChallenge': isGroupChallenge,
      'participantIds': participantIds,
      'creatorId': creatorId,
      'participantProgress': participantProgress,
      'isPremiumOnly': isPremiumOnly,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    return Challenge(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      type: ChallengeType.values.firstWhere(
        (e) => e.toString().split('.').last == map['type'],
        orElse: () => ChallengeType.custom,
      ),
      xpReward: map['xpReward'],
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      targetGoal: map['targetGoal'],
      iconPath: map['iconPath'],
      isGroupChallenge: map['isGroupChallenge'] ?? false,
      participantIds: List<String>.from(map['participantIds'] ?? []),
      creatorId: map['creatorId'],
      participantProgress: Map<String, int>.from(
        map['participantProgress'] ?? {},
      ),
      isPremiumOnly: map['isPremiumOnly'] ?? false,
    );
  }
}
