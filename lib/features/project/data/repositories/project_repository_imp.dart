import 'package:task_manager_app/core/networks/app_session.dart';
import 'package:task_manager_app/features/project/data/service/project_api_services.dart';
import 'package:task_manager_app/features/project/domain/entities/project_entities.dart';
import 'package:task_manager_app/features/project/domain/repositories/project_repository.dart';

class ProjectRepositoryImp implements ProjectRepository {
  final ProjectApiService remoteService;

  ProjectRepositoryImp(this.remoteService);

  @override
  Future<List<ProjectEntities>> getAllProject() async {
    try {
      final token = AppSession.token!;
      final projects = await remoteService.getAllProject(token);
      return projects;
    } catch (e) {
      throw Exception("Repository error: $e");
    }
  }
}
