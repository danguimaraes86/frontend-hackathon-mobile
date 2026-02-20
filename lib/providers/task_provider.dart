import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final _taskService = TaskService();
  StreamSubscription<List<Task>>? _tasksSubscription;

  List<Task> _allUserTasks = [];
  List<Task> get allTasks => List.unmodifiable(_allUserTasks);
  List<Task> get completedTasks => _filterByStatus(TaskStatus.completed);
  List<Task> get inProgressTasks => _filterByStatus(TaskStatus.inProgress);
  List<Task> get pendingTasks => _filterByStatus(TaskStatus.pending);

  List<Task> _filterByStatus(TaskStatus status) =>
      _allUserTasks.where((t) => t.status == status).toList();

  void watchAllTasks() {
    _tasksSubscription?.cancel();
    _tasksSubscription = _taskService.watchTasks().listen((tasks) {
      _allUserTasks = tasks;
      notifyListeners();
    });
  }

  Future<void> addTask(Task task) async {
    await _taskService.addTask(task);
    notifyListeners();
  }

  Future<void> deleteTask(String taskId) async {
    await _taskService.deleteTask(taskId);
    notifyListeners();
  }

  Future<void> updateTask(String taskId, Task updatedTask) async {
    await _taskService.updateTask(taskId, updatedTask);
  }

  Future<void> updateTaskStatus(String taskId, TaskStatus status) async {
    final current = _allUserTasks.firstWhere((t) => t.id == taskId);
    await _taskService.updateTask(taskId, current.withStatus(status));
  }

  Future<void> startPendingTask(String taskId) async {
    await updateTaskStatus(taskId, TaskStatus.inProgress);
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }
}
