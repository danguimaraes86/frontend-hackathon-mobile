import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';

class TaskService {
  final _taskCollection = FirebaseFirestore.instance.collection('tasks');
  final _auth = FirebaseAuth.instance;

  String get _currentUserId => _auth.currentUser!.uid;

  Stream<List<Task>> watchTasks() {
    return _taskCollection
        .where('userId', isEqualTo: _currentUserId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Task.fromJson({...doc.data(), 'id': doc.id}))
              .toList(),
        );
  }

  Future<void> addTask(Task task) async {
    await _taskCollection.add(task.withUserId(_currentUserId).toJson());
  }

  Future<void> deleteTask(String taskId) async {
    await _taskCollection.doc(taskId).delete();
  }

  Future<void> updateTask(String taskId, Task updatedTask) async {
    await _taskCollection.doc(taskId).update(updatedTask.toJson());
  }
}
