import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/mindfulness_session_model.dart';

class MindfulnessRepository {
  final FirebaseFirestore _firestore;

  MindfulnessRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _mindfulnessCollection =>
      _firestore.collection('mindfulness_sessions');

  Stream<List<MindfulnessSession>> getMindfulnessSessions(String userId) {
    return _mindfulnessCollection
        .where('userId', isEqualTo: userId)
        .orderBy('startTime', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => MindfulnessSession.fromMap(doc.data()))
              .toList();
        });
  }

  Future<MindfulnessSession?> getMindfulnessSessionById(String id) async {
    final doc = await _mindfulnessCollection.doc(id).get();
    if (doc.exists) {
      return MindfulnessSession.fromMap(doc.data()!);
    }
    return null;
  }

  Future<void> addMindfulnessSession(MindfulnessSession session) async {
    await _mindfulnessCollection.doc(session.id).set(session.toMap());
  }

  Future<void> updateMindfulnessSession(MindfulnessSession session) async {
    await _mindfulnessCollection.doc(session.id).update(session.toMap());
  }

  Future<void> deleteMindfulnessSession(String sessionId) async {
    await _mindfulnessCollection.doc(sessionId).delete();
  }
}
