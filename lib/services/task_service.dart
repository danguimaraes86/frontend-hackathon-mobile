import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';
import 'repositories/task_repository.dart';

class TaskService {
  final _taskRepository = TaskRepository();
  final _auth = FirebaseAuth.instance;

  String get _currentUserId => _auth.currentUser!.uid;

  Stream<List<Task>> watchTasks() {
    return _taskRepository.watchAllTasksByUserId(_currentUserId);
  }

  Future<Task> addTask(Task task) async {
    final newTask = task.withUserId(_currentUserId);
    final taskId = await _taskRepository.createTask(newTask);
    return newTask.withId(taskId);
  }

  Future<void> deleteTask(String taskId) async {
    await _taskRepository.deleteTask(taskId);
  }

  Future<Task> updateTask(String taskId, Task updatedTask) async {
    await _taskRepository.updateTask(taskId, updatedTask);
    return updatedTask;
  }
}
