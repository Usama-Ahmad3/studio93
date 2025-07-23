import 'package:studio93/domain/task_model.dart';

abstract class FirebaseRepoInterface {
  Future<List<TaskModelEntity>> getTasks(String userId);
  Future<void> addTask({
    required Map<String, dynamic> model,
    required String userId,
  });
  Future<void> updateTask({
    required Map<String, dynamic> model,
    required String id,
    required String userId,
  });
  Future<void> deleteTask({required String id, required String userId});
}
