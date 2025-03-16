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
        .orderBy('startTime', descending: