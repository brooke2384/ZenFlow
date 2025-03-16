import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/journal_entry_model.dart';

class JournalRepository {
  final FirebaseFirestore _firestore;

  JournalRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _journalCollection =>
      _firestore.collection('journal_entries');

  Stream<List<JournalEntry>> getJournalEntries(String userId) {
    return _journalCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => JournalEntry.fromMap(doc.data()))
          .toList();
    });
  }

  Future<void> addJournalEntry(JournalEntry entry) async {
    await _journalCollection.doc(entry.id).set(entry.toMap());
  }

  Future<void> updateJournalEntry(JournalEntry entry) async {
    await _journalCollection.doc(entry.id).update(entry.toMap());
  }

  Future<void> deleteJournalEntry(String entryId) async {
    await _journalCollection.doc(entryId).delete();
  }

  Stream<List<JournalEntry>> getJournalEntriesByMood(
      String userId, MoodType mood) {
    return _journalCollection
        .where('userId', isEqualTo: userId)
        .where('mood', isEqualTo: mood.toString().split('.').last)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => JournalEntry.fromMap(doc.data()))
          .toList();
    });
  }

  Stream<List<JournalEntry>> getJournalEntriesByTag(
      String userId, String tag) {
    return _journalCollection
        .where('userId', isEqualTo: userId)
        .where('tags', arrayContains: tag)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => JournalEntry.fromMap(doc.data()))
          .toList();
    });
  }
}

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return JournalRepository();
});