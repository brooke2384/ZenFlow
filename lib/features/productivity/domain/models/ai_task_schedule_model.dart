import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:zenflow/features/tasks/domain/models/task_model.dart';

enum FocusLevel { high, medium, low }

enum EnergyLevel { high, medium, low }

class AITaskSchedule {
  final String id;
  final String userId;
  final DateTime scheduledDate;
  final List<ScheduledTask> tasks;
  final Map<String, dynamic>? aiInsights;
  final DateTime createdAt;
  final DateTime? lastUpdatedAt;

  AITaskSchedule({
    String? id,
    required this.userId,
    required this.scheduledDate,
    List<ScheduledTask>? tasks,
    this.aiInsights,
    DateTime? createdAt,
    this.lastUpdatedAt,
  }) : id = id ?? const Uuid().v4(),
       tasks = tasks ?? [],
       createdAt = createdAt ?? DateTime.now();

  AITaskSchedule copyWith({
    DateTime? scheduledDate,
    List<ScheduledTask>? tasks,
    Map<String, dynamic>? aiInsights,
    DateTime? lastUpdatedAt,
  }) {
    return AITaskSchedule(
      id: id,
      userId: userId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      tasks: tasks ?? this.tasks,
      aiInsights: aiInsights ?? this.aiInsights,
      createdAt: createdAt,
      lastUpdatedAt: lastUpdatedAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'scheduledDate': Timestamp.fromDate(scheduledDate),
      'tasks': tasks.map((task) => task.toMap()).toList(),
      'aiInsights': aiInsights,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastUpdatedAt':
          lastUpdatedAt != null ? Timestamp.fromDate(lastUpdatedAt!) : null,
    };
  }

  factory AITaskSchedule.fromMap(Map<String, dynamic> map) {
    return AITaskSchedule(
      id: map['id'],
      userId: map['userId'],
      scheduledDate: (map['scheduledDate'] as Timestamp).toDate(),
      tasks:
          (map['tasks'] as List)
              .map((taskMap) => ScheduledTask.fromMap(taskMap))
              .toList(),
      aiInsights: map['aiInsights'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastUpdatedAt:
          map['lastUpdatedAt'] != null
              ? (map['lastUpdatedAt'] as Timestamp).toDate()
              : null,
    );
  }
}

class ScheduledTask {
  final String taskId;
  final String title;
  final DateTime scheduledStartTime;
  final Duration estimatedDuration;
  final FocusLevel requiredFocusLevel;
  final EnergyLevel requiredEnergyLevel;
  final TaskPriority priority;
  final bool isCompleted;

  ScheduledTask({
    required this.taskId,
    required this.title,
    required this.scheduledStartTime,
    required this.estimatedDuration,
    this.requiredFocusLevel = FocusLevel.medium,
    this.requiredEnergyLevel = EnergyLevel.medium,
    this.priority = TaskPriority.medium,
    this.isCompleted = false,
  });

  ScheduledTask copyWith({
    DateTime? scheduledStartTime,
    Duration? estimatedDuration,
    FocusLevel? requiredFocusLevel,
    EnergyLevel? requiredEnergyLevel,
    TaskPriority? priority,
    bool? isCompleted,
  }) {
    return ScheduledTask(
      taskId: taskId,
      title: title,
      scheduledStartTime: scheduledStartTime ?? this.scheduledStartTime,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      requiredFocusLevel: requiredFocusLevel ?? this.requiredFocusLevel,
      requiredEnergyLevel: requiredEnergyLevel ?? this.requiredEnergyLevel,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'title': title,
      'scheduledStartTime': Timestamp.fromDate(scheduledStartTime),
      'estimatedDurationMinutes': estimatedDuration.inMinutes,
      'requiredFocusLevel': requiredFocusLevel.toString().split('.').last,
      'requiredEnergyLevel': requiredEnergyLevel.toString().split('.').last,
      'priority': priority.toString().split('.').last,
      'isCompleted': isCompleted,
    };
  }

  factory ScheduledTask.fromMap(Map<String, dynamic> map) {
    return ScheduledTask(
      taskId: map['taskId'],
      title: map['title'],
      scheduledStartTime: (map['scheduledStartTime'] as Timestamp).toDate(),
      estimatedDuration: Duration(minutes: map['estimatedDurationMinutes']),
      requiredFocusLevel: FocusLevel.values.firstWhere(
        (e) => e.toString().split('.').last == map['requiredFocusLevel'],
        orElse: () => FocusLevel.medium,
      ),
      requiredEnergyLevel: EnergyLevel.values.firstWhere(
        (e) => e.toString().split('.').last == map['requiredEnergyLevel'],
        orElse: () => EnergyLevel.medium,
      ),
      priority: TaskPriority.values.firstWhere(
        (e) => e.toString().split('.').last == map['priority'],
        orElse: () => TaskPriority.medium,
      ),
      isCompleted: map['isCompleted'] ?? false,
    );
  }
}
