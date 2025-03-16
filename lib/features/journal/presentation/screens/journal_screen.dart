import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenflow/features/journal/domain/models/journal_entry_model.dart';
import 'package:zenflow/features/journal/presentation/providers/journal_provider.dart';
import 'package:zenflow/features/auth/presentation/providers/auth_provider.dart';
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
              '${entry.createdAt.day}/${entry.createdAt.month}/${entry.createdAt.year}',
            ),
            onTap: () => _showEntryDetails(context, entry),
          ),
        );
      },
    );
  }

  void _showAddEntryDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    MoodType? selectedMood;

    showDialog(
      context: context,
      builder:
          (context) => Consumer(
            builder: (context, ref, _) {
              return AlertDialog(
                title: const Text('New Journal Entry'),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: contentController,
                        decoration: const InputDecoration(labelText: 'Content'),
                        maxLines: 5,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<MoodType>(
                        decoration: const InputDecoration(labelText: 'Mood'),
                        items:
                            MoodType.values.map((mood) {
                              return DropdownMenuItem(
                                value: mood,
                                child: Text(mood.toString().split('.').last),
                              );
                            }).toList(),
                        onChanged: (value) {
                          selectedMood = value;
                        },
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      final user = ref.read(currentUserProvider);
                      if (user != null &&
                          titleController.text.isNotEmpty &&
                          contentController.text.isNotEmpty) {
                        final entry = JournalEntry(
                          title: titleController.text,
                          content: contentController.text,
                          mood: selectedMood,
                          userId: user.uid,
                        );

                        ref
                            .read(journalRepositoryProvider)
                            .addJournalEntry(entry);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          ),
    );
  }

  void _showEntryDetails(BuildContext context, JournalEntry entry) {
    showDialog(
      context: context,
      builder:
          (context) => Consumer(
            builder: (context, ref, _) {
              return AlertDialog(
                title: Text(entry.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${entry.createdAt.day}/${entry.createdAt.month}/${entry.createdAt.year}',
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                      const SizedBox(height: 8),
                      if (entry.mood != null)
                        Chip(
                          label: Text(entry.mood.toString().split('.').last),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.secondary.withOpacity(0.2),
                        ),
                      const SizedBox(height: 16),
                      Text(entry.content),
                      if (entry.tags.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          children:
                              entry.tags
                                  .map((tag) => Chip(label: Text(tag)))
                                  .toList(),
                        ),
                      ],
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ref
                          .read(journalRepositoryProvider)
                          .deleteJournalEntry(entry.id);
                    },
                    child: const Text('Delete'),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                ],
              );
            },
          ),
    );
  }
}
