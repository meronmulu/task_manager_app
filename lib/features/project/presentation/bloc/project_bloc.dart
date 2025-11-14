import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/project/domain/repositories/project_repository.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_event.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository repository;

  ProjectBloc(this.repository) : super(ProjectIntial()) {
    on<FetchAllProject>(_onFetchAllProject);
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
}
