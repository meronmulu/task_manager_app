import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/project/domain/repositories/project_repository.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_event.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository repository;

  ProjectBloc(this.repository) : super(ProjectIntial()) {
    on<FetchAllProject>(_onFetchAllProject);
    on<AddProjectRequested>(_onAddProjectRequested);
    on<EditProjectRequested>(_onEditProjectRequested);
  }

  Future<void> _onFetchAllProject(
    FetchAllProject event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    try {
      final projects = await repository.getAllProject();
      emit(ProjectsLoaded(projects));
    } catch (e) {
      emit(ProjectFailure(e.toString()));
    }
  }

  Future<void> _onAddProjectRequested(
    AddProjectRequested event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    try {
      final newProject = await repository.addProject(
        projectName: event.projectName,
        description: event.description,
        status: event.status,
      );
      emit(ProjectSuccess(newProject));
    } catch (e) {
      emit(ProjectFailure(e.toString()));
    }
  }

  Future<void> _onEditProjectRequested(
    EditProjectRequested event,
    Emitter<ProjectState> emit,
  ) async {
    emit(ProjectLoading());
    try {
      final updatedProject = await repository.editProject(
        projectId: event.projectId,
        projectName: event.projectName,
        description: event.description,
        status: event.status,
      );
      emit(ProjectSuccess(updatedProject));
    } catch (e) {
      emit(ProjectFailure(e.toString()));
    }
  }
}
