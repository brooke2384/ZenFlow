import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum SessionType {
  meditation,
  breathing,
  yoga,
  journaling,
  soundTherapy,
  guidedVisualization,
}

class MindfulnessSession {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final Duration duration;
  final SessionType type;
  final int? stressLevelBefore;
  final int? stressLevelAfter;
  final String? notes;
  final String userId;
  final Map<String, dynamic>? aiInsights;

  MindfulnessSession({
    String? id,
    required this.title,
    this.description = '',
    required this.startTime,
    required this.duration,
    required this.type,
    this.stressLevelBefore,
    this.stressLevelAfter,
    this.notes,
    required this.userId,
    this.aiInsights,
  }) : id = id ?? const Uuid().v4();

  MindfulnessSession copyWith({
    String? title,
    String? description,
    DateTime? startTime,
    Duration? duration,
    SessionType? type,
    int? stressLevelBefore,
    int? stressLevelAfter,
    String? notes,
    Map<String, dynamic>? aiInsights,
  }) {
    return MindfulnessSession(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      stressLevelBefore: stressLevelBefore ?? this.stressLevelBefore,
      stressLevelAfter: stressLevelAfter ?? this.stressLevelAfter,
      notes: notes ?? this.notes,
      userId: userId,
      aiInsights: aiInsights ?? this.aiInsights,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startTime': Timestamp.fromDate(startTime),
      'durationInMinutes': duration.inMinutes,
      'type': type.toString().split('.').last,
      'stressLevelBefore': stressLevelBefore,
      'stressLevelAfter': stressLevelAfter,
      'notes': notes,
      'userId': userId,
      'aiInsights': aiInsights,
    };
  }

  factory MindfulnessSession.fromMap(Map<String, dynamic> map) {
    return MindfulnessSession(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      startTime: (map['startTime'] as Timestamp).toDate(),
      duration: Duration(minutes: map['durationInMinutes']),
      type:
          map['type'] != null
              ? SessionType.values.firstWhere(
                (e) => e.toString().split('.').last == map['type'],
                orElse: () => SessionType.meditation,
              )
              : SessionType.meditation,
      stressLevelBefore: map['stressLevelBefore'],
      stressLevelAfter: map['stressLevelAfter'],
      notes: map['notes'],
      userId: map['userId'],
      aiInsights: map['aiInsights'],
    );
  }
}
