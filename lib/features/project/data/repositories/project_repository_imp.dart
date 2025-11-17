import 'package:task_manager_app/features/project/data/model/project_model.dart';
import 'package:task_manager_app/features/project/data/service/project_api_services.dart';
import 'package:task_manager_app/features/project/domain/entities/project_entities.dart';
import 'package:task_manager_app/features/project/domain/repositories/project_repository.dart';

class ProjectRepositoryImp implements ProjectRepository {
  final ProjectApiService remoteService;

  ProjectRepositoryImp(this.remoteService);

  @override
  Future<List<ProjectEntities>> getAllProject() async {
    try {
      return await remoteService.getAllProject();
    } catch (e) {
      throw Exception("Repository error: $e");
    }
  }

  Future<ProjectEntities> addProject({
    required String projectName,
    required String description,
    required String status,
  }) async {
    try {
      final ProjectModel project = await remoteService.addProject(
        projectName: projectName,
        description: description,
        status: status,
      );
      return project;
    } catch (e) {
      throw Exception("Repository error (addProject): $e");
    }
  }

  Future<ProjectEntities> editProject({
    required int projectId,
    required String projectName,
    required String description,
    required String status,
  }) async {
    try {
      final ProjectModel project = await remoteService.editProject(
        projectId: projectId,
        projectName: projectName,
        description: description,
        status: status,
      );
      return project;
    } catch (e) {
      throw Exception("Repository error (editProject): $e");
    }
  }

  @override
  Future<void> deleteProject(int projectId) {
    throw UnimplementedError();
  }
}
