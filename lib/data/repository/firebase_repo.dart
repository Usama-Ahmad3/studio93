import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studio93/domain/firebase_repo_interface.dart';
import 'package:studio93/domain/task_model.dart';

class FirebaseRepo implements FirebaseRepoInterface {
  @override
  Future<List<TaskModelEntity>> getTasks(String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => TaskModelEntity.fromDocument(doc))
        .toList();
  }

  @override
  Future<void> addTask({
    required Map<String, dynamic> model,
    required String userId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .add(model);
  }

  @override
  Future<void> updateTask({
    required Map<String, dynamic> model,
    required String id,
    required String userId,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(id)
        .update(model);
  }

  @override
  Future<void> deleteTask({required String id, required String userId}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('tasks')
        .doc(id)
        .delete();
  }
}
