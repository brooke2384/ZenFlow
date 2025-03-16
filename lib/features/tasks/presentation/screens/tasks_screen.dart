import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_notifier.dart';
import '../../domain/models/task_model.dart';
import '../widgets/task_card.dart';
import '../widgets/add_task_dialog.dart';
import '../../../../widgets/common/zen_app_bar.dart';
import '../../../../widgets/common/zen_bottom_nav.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isKanbanView = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZenAppBar(
        title: 'Tasks',
        actions: [
          IconButton(
            icon: Icon(_isKanbanView ? Icons.view_list : Icons.view_column),
            onPressed: () {
              setState(() {
                _isKanbanView = !_isKanbanView;
              });
            },
          ),
        ],
      ),
      body: _isKanbanView ? _buildKanbanView() : _buildListView(),
      bottomNavigationBar: const ZenBottomNav(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddTaskDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildKanbanView() {
    return Row(
      children: [
        Expanded(
          child: _buildTaskColumn(
            'To Do',
            TaskStatus.pending,
            Colors.blue.shade100,
          ),
        ),
        Expanded(
          child: _buildTaskColumn(
            'In Progress',
            TaskStatus.inProgress,
            Colors.amber.shade100,
          ),
        ),
        Expanded(
          child: _buildTaskColumn(
            'Completed',
            TaskStatus.completed,
            Colors.green.shade100,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskColumn(String title, TaskStatus status, Color color) {
    final tasks = ref.watch(filteredTasksProvider(status));

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            child: DragTarget<Task>(
              onAccept: (task) {
                final updatedTask = task.copyWith(status: status);
                ref
                    .read(taskNotifierProvider(task.userId).notifier)
                    .updateTask(updatedTask);
              },
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Draggable<Task>(
                      data: task,
                      feedback: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TaskCard(task: task, isDragging: true),
                      ),
                      childWhenDragging: Opacity(
                        opacity: 0.5,
                        child: TaskCard(task: task),
                      ),
                      child: TaskCard(task: task),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    final pendingTasks = ref.watch(filteredTasksProvider(TaskStatus.pending));
    final inProgressTasks = ref.watch(
      filteredTasksProvider(TaskStatus.inProgress),
    );
    final completedTasks = ref.watch(
      filteredTasksProvider(TaskStatus.completed),
    );

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'To Do'),
              Tab(text: 'In Progress'),
              Tab(text: 'Completed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTaskList(pendingTasks, TaskStatus.pending),
                _buildTaskList(inProgressTasks, TaskStatus.inProgress),
                _buildTaskList(completedTasks, TaskStatus.completed),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList(List<Task> tasks, TaskStatus status) {
    return tasks.isEmpty
        ? const Center(child: Text('No tasks yet'))
        : ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskCard(task: task);
          },
        );
  }
}
