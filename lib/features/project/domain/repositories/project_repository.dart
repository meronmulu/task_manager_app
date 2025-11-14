import 'package:task_manager_app/features/project/domain/entities/project_entities.dart';

abstract class ProjectRepository {
  Future<List<ProjectEntities>> getAllProject();
}
