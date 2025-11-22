import 'package:task_manager_app/features/tasks/domian/entities/task_entities.dart';

abstract class TaskRepository {
  Future<List<TaskEntity>> getAllTasks();
  Future<List<TaskEntity>> getTasksByProject(int projectId);
  Future<TaskEntity> addTasks({
    required String title,
    required String description,
    required String status,
    required String priority,
    required int projectId,
    required int assignedToId,
    required DateTime dueDate,
  });
}
