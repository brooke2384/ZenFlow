import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

enum TaskStatus { pending, inProgress, completed }

enum TaskPriority { high, medium, low }

class Task {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final TaskStatus status;
  final TaskPriority priority;
  final List<String> tags;
  final bool isRecurring;
  final String? recurrencePattern;
  final String userId;
  final Map<String, dynamic>? aiSuggestions;

  Task({
    String? id,
    required this.title,
    this.description = '',
    DateTime? createdAt,
    this.dueDate,
    this.status = TaskStatus.pending,
    this.priority = TaskPriority.medium,
    List<String>? tags,
    this.isRecurring = false,
    this.recurrencePattern,
    required this.userId,
    this.aiSuggestions,
  }) : id = id ?? const Uuid().v4(),
       createdAt = createdAt ?? DateTime.now(),
       tags = tags ?? [];

  Task copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    TaskStatus? status,
    TaskPriority? priority,
    List<String>? tags,
    bool? isRecurring,
    String? recurrencePattern,
    Map<String, dynamic>? aiSuggestions,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      tags: tags ?? this.tags,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrencePattern: recurrencePattern ?? this.recurrencePattern,
      userId: userId,
      aiSuggestions: aiSuggestions ?? this.aiSuggestions,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': Timestamp.fromDate(createdAt),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'status': status.toString().split('.').last,
      'priority': priority.toString().split('.').last,
      'tags': tags,
      'isRecurring': isRecurring,
      'recurrencePattern': recurrencePattern,
      'userId': userId,
      'aiSuggestions': aiSuggestions,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      dueDate:
          map['dueDate'] != null
              ? (map['dueDate'] as Timestamp).toDate()
              : null,
      status:
          map['status'] != null
              ? TaskStatus.values.firstWhere(
                (e) => e.toString().split('.').last == map['status'],
                orElse: () => TaskStatus.pending,
              )
              : TaskStatus.pending,
      priority:
          map['priority'] != null
              ? TaskPriority.values.firstWhere(
                (e) => e.toString().split('.').last == map['priority'],
                orElse: () => TaskPriority.medium,
              )
              : TaskPriority.medium,
      tags: List<String>.from(map['tags'] ?? []),
      isRecurring: map['isRecurring'] ?? false,
      recurrencePattern: map['recurrencePattern'],
      userId: map['userId'],
      aiSuggestions: map['aiSuggestions'],
    );
  }
}
