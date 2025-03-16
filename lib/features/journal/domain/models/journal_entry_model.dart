import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum MoodType {
  happy,
  calm,
  neutral,
  sad,
  stressed,
  angry,
  excited,
  tired,
  grateful
}

class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final MoodType? mood;
  final List<String> tags;
  final List<String> imageUrls;
  final String userId;
  final Map<String, dynamic>? aiAnalysis;

  JournalEntry({
    String? id,
    required this.title,
    required this.content,
    DateTime? createdAt,
    this.mood,
    List<String>? tags,
    List<String>? imageUrls,
    required this.userId,
    this.aiAnalysis,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        tags = tags ?? [],
        imageUrls = imageUrls ?? [];

  JournalEntry copyWith({
    String? title,
    String? content,
    MoodType? mood,
    List<String>? tags,
    List<String>? imageUrls,
    Map<String, dynamic>? aiAnalysis,
  }) {
    return JournalEntry(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      mood: mood ?? this.mood,
      tags: tags ?? this.tags,
      imageUrls: imageUrls ?? this.imageUrls,
      userId: userId,
      aiAnalysis: aiAnalysis ?? this.aiAnalysis,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
      'mood': mood?.toString().split('.').last,
      'tags': tags,
      'imageUrls': imageUrls,
      'userId': userId,
      'aiAnalysis': aiAnalysis,
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      mood: map['mood'] != null
          ? MoodType.values.firstWhere(
              (e) => e.toString().split('.').last == map['mood'],
              orElse: () => MoodType.neutral,
            )
          : null,
      tags: List<String>.from(map['tags'] ?? []),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      userId: map['userId'],
      aiAnalysis: map['aiAnalysis'],
    );
  }
}