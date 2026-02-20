import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/task_model.dart';

class TaskRepository {
  final _taskCollection = FirebaseFirestore.instance.collection('tasks');

  Stream<List<Task>> watchAllTasksByUserId(String userId) {
    return _taskCollection
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Task.fromJson({...doc.data(), 'id': doc.id}))
              .toList(),
        );
  }

  Future<String> createTask(Task task) async {
    final docRef = await _taskCollection.add(task.toJson());
    return docRef.id;
  }

  Future<void> updateTask(String docId, Task task) async {
    await _taskCollection.doc(docId).update(task.toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _taskCollection.doc(taskId).delete();
  }
}
