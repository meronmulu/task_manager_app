import 'package:task_manager_app/features/tasks/data/models/task_models.dart';
import 'package:task_manager_app/features/tasks/data/servies/task_services.dart';
import 'package:task_manager_app/features/tasks/domian/entities/task_entities.dart';
import 'package:task_manager_app/features/tasks/domian/repositories/task_repositories.dart';

class TaskRepositoryImp implements TaskRepository {
  final TaskServices remoteService;

  TaskRepositoryImp(this.remoteService);

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    try {
      return await remoteService.getAllTasks();
    } catch (e) {
      throw Exception("Repository error: $e");
    }
  }

  @override
  Future<List<TaskEntity>> getTasksByProject(int projectId) async {
    try {
      return await remoteService.getTasksByProject(projectId);
    } catch (e) {
      throw Exception("Repository error: $e");
    }
  }

  @override
  Future<TaskEntity> addTasks({
    required String title,
    required String description,
    required String status,
    required String priority,
    required int projectId,
    required int assignedToId,
    required DateTime dueDate,
  }) async {
    try {
      final TaskModel task = await remoteService.addTasks(
        title: title,
        description: description,
        status: status,
        priority: priority,
        projectId: projectId,
        assignedToId: assignedToId,
        dueDate: dueDate,
      );
      return task;
    } catch (e) {
      throw Exception("Repository error: $e");
    }
  }
}
