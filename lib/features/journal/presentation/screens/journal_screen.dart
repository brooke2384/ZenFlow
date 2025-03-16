import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenflow/features/journal/domain/models/journal_entry_model.dart';
import 'package:zenflow/features/journal/presentation/providers/journal_provider.dart';
import 'package:zenflow/widgets/common/zen_app_bar.dart';
import 'package:zenflow/widgets/common/zen_bottom_nav.dart';

class JournalScreen extends ConsumerWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(journalEntriesProvider);

    return Scaffold(
      appBar: const ZenAppBar(title: 'Journal'),
      body: entriesAsync.when(
        data: (entries) => _buildEntriesList(context, entries),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEntryDialog(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const ZenBottomNav(),
    );
  }

  Widget _buildEntriesList(BuildContext context, List<JournalEntry> entries) {
    if (entries.isEmpty) {
      return const Center(
        child: Text('No journal entries yet. Create one to get started!'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListTile(
            title: Text(entry.title),
            subtitle: Text(
              entry.content.length > 50
                  ? '${entry.content.substring(0, 50)}...'
                  : entry.content,
            ),
            trailing: Text(
              '${entry.date.day}/${entry.date.month}/${entry.date.year}',
            ),
            onTap: () => _showEntryDetails(context, entry),
          ),
        );
      },
    );
  }

  void _showAddEntryDialog(BuildContext context) {
    // Implementation for adding a new entry
  }

  void _showEntryDetails(BuildContext context, JournalEntry entry) {
    // Implementation for showing entry details
  }
}