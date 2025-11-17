import 'package:equatable/equatable.dart';

abstract class ProjectEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchAllProject extends ProjectEvent {}

class AddProjectRequested extends ProjectEvent {
  final String projectName;
  final String description;
  final String status;

  AddProjectRequested({
    required this.projectName,
    required this.description,
    required this.status,
  });

  @override
  List<Object?> get props => [projectName, description, status];
}

class EditProjectRequested extends ProjectEvent {
  final int projectId;
  final String projectName;
  final String description;
  final String status;

  EditProjectRequested({
    required this.projectId,
    required this.projectName,
    required this.description,
    required this.status,
  });

  @override
  List<Object?> get props => [projectId, projectName, description, status];
}
