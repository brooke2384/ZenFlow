import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/task_model.dart';
import '../../data/repositories/task_repository.dart';
import 'package:zenflow/features/auth/presentation/providers/auth_provider.dart';

class TaskNotifier extends StateNotifier<AsyncValue<List<Task>>> {
  final TaskRepository _repository;
  final String _userId;

  TaskNotifier({required TaskRepository repository, required String userId})
      : _repository = repository,
        _userId = userId,
        super(const AsyncValue.loading()) {
    _fetchTasks();
  }

  void _fetchTasks() {
    _repository.getTasks(_userId).listen(
          (tasks) => state = AsyncValue.data(tasks),
          onError: (error) => state = AsyncValue.error(error, StackTrace.current),
        );
  }

  Future<void> addTask(Task task) async {
    try {
      await _repository.addTask(task);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await _repository.updateTask(task);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _repository.deleteTask(taskId);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> toggleTaskStatus(Task task) async {
    final newStatus = task.status == TaskStatus.completed
        ? TaskStatus.pending
        : TaskStatus.completed;
    
    final updatedTask = task.copyWith(status: newStatus);
    await updateTask(updatedTask);
  }

  Future<void> updateTaskPriority(Task task, TaskPriority priority) async {
    final updatedTask = task.copyWith(priority: priority);
    await updateTask(updatedTask);
  }
}

final taskNotifierProvider = StateNotifierProvider.family<TaskNotifier, AsyncValue<List<Task>>, String>(
  (ref, userId) {
    final repository = ref.watch(taskRepositoryProvider);
    return TaskNotifier(repository: repository, userId: userId);
  },
);

final currentUserTasksProvider = Provider<AsyncValue<List<Task>>>((ref) {
  final authState = ref.watch(authStateProvider);
  
  return authState.when(
    data: (user) {
      if (user == null) return const AsyncValue.data([]);
      return ref.watch(taskNotifierProvider(user.uid));
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
  );
});

final filteredTasksProvider = Provider.family<List<Task>, TaskStatus?>((ref, status) {
  final tasksAsyncValue = ref.watch(currentUserTasksProvider);
  
  return tasksAsyncValue.when(
    data: (tasks) {
      if (status == null) return tasks;
      return tasks.where((task) => task.status == status).toList();
    },
    loading: () => [],
    error: (_, __) => [],
  );
});