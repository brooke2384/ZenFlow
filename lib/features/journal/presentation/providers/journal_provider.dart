import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenflow/features/auth/presentation/providers/auth_provider.dart';
import 'package:zenflow/features/journal/data/repositories/journal_repository.dart';
import 'package:zenflow/features/journal/domain/models/journal_entry_model.dart';

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return JournalRepository();
});

final journalEntriesProvider = StreamProvider<List<JournalEntry>>((ref) {
  final repository = ref.watch(journalRepositoryProvider);
  final user = ref.watch(currentUserProvider);

  if (user == null) {
    return Stream.value([]);
  }

  return repository.getJournalEntries(user.uid);
});

final journalEntryProvider = FutureProvider.family<JournalEntry?, String>((
  ref,
  id,
) {
  final repository = ref.watch(journalRepositoryProvider);
  return repository.getJournalEntryById(id);
});
