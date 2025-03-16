import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zenflow/features/auth/presentation/providers/auth_provider.dart';
import 'package:zenflow/features/mindfulness/data/repositories/mindfulness_repository.dart';
import 'package:zenflow/features/mindfulness/domain/models/mindfulness_session_model.dart';

final mindfulnessRepositoryProvider = Provider<MindfulnessRepository>((ref) {
  return MindfulnessRepository();
});

final mindfulnessSessionsProvider = StreamProvider<List<MindfulnessSession>>((ref) {
  final repository = ref.watch(mindfulnessRepositoryProvider);
  final user = ref.watch(currentUserProvider);
  
  if (user == null) {
    return Stream.value([]);
  }
  
  return repository.getMindfulnessSessions(user.uid);
});

final mindfulnessSessionProvider = FutureProvider.family<MindfulnessSession?, String>((ref, id) {
  final repository = ref.watch(mindfulnessRepositoryProvider);
  return repository.getMindfulnessSessionById(id);
});