import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenflow/features/mindfulness/domain/models/mindfulness_session_model.dart';
import 'package:zenflow/features/mindfulness/presentation/providers/mindfulness_provider.dart';
import 'package:zenflow/widgets/common/zen_app_bar.dart';
import 'package:zenflow/widgets/common/zen_bottom_nav.dart';

class MindfulnessScreen extends ConsumerWidget {
  const MindfulnessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(mindfulnessSessionsProvider);

    return Scaffold(
      appBar: const ZenAppBar(title: 'Mindfulness'),
      body: sessionsAsync.when(
        data: (sessions) => _buildSessionsList(context, sessions),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSessionDialog(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const ZenBottomNav(),
    );
  }

  Widget _buildSessionsList(BuildContext context, List<MindfulnessSession> sessions) {
    if (sessions.isEmpty) {
      return const Center(
        child: Text('No mindfulness sessions yet. Create one to get started!'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text(session.title),
            subtitle: Text(
              '${session.type.toString().split('.').last} - ${session.duration.inMinutes} min',
            ),
            trailing: Text(
              '${session.startTime.day}/${session.startTime.month}/${session.startTime.year}',
            ),
            onTap: () => _showSessionDetails(context, session),
          ),
        );
      },
    );
  }

  void _showAddSessionDialog(BuildContext context) {
    // Implementation for adding a new session
  }

  void _showSessionDetails(BuildContext context, MindfulnessSession session) {
    // Implementation for showing session details
  }
}