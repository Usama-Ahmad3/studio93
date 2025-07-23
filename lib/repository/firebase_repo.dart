import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studio93/domain/gemini_response_model_entity.dart';

class FirebaseRepo {
  Future<List<GeminiResponseModelEntity>> getTasks() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => GeminiResponseModelEntity.fromDocument(doc))
        .toList();
  }

  Future<void> addTask({required Map<String, dynamic> model}) async {
    await FirebaseFirestore.instance.collection('tasks').add(model);
  }

  Future<void> updateTask({
    required Map<String, dynamic> model,
    required String id,
  }) async {
    await FirebaseFirestore.instance.collection('tasks').doc(id).update(model);
  }

  Future<void> deleteTask({required String id}) async {
    await FirebaseFirestore.instance.collection('tasks').doc(id).delete();
  }
}
