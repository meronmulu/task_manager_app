import 'package:equatable/equatable.dart';
import 'package:task_manager_app/features/project/domain/entities/project_entities.dart';

abstract class ProjectState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProjectIntial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectSuccess extends ProjectState {
  final ProjectEntities projects;

  ProjectSuccess(this.projects);

  @override
  List<Object?> get props => [projects];
}

class ProjectFailure extends ProjectState {
  final String error;

  ProjectFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class ProjectsLoaded extends ProjectState {
  final List<ProjectEntities> projects;

  ProjectsLoaded(this.projects);

  @override
  List<Object?> get props => [projects];
}
