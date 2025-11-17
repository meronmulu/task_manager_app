import 'package:task_manager_app/features/project/domain/entities/project_entities.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntities>> getAllProject();
  Future<ProjectEntities> addProject({
    required String projectName,
    required String description,
    required String status,
  });

  Future<ProjectEntities> editProject({
    required int projectId,
    required String projectName,
    required String description,
    required String status,
  });

  Future<void> deleteProject(int projectId);
}
