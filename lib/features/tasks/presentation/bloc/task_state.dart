import 'package:equatable/equatable.dart';
import 'package:task_manager_app/features/tasks/domian/entities/task_entities.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskSuccess extends TaskState {
  final List<TaskEntity> tasks;

  TaskSuccess(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskFailure extends TaskState {
  final String error;

  TaskFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class TasksLoaded extends TaskState {
  final List<TaskEntity> tasks;

  TasksLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskDeleted extends TaskState {
  final int taskId;

  TaskDeleted(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class TaskAdded extends TaskState {
  final TaskEntity task;

  TaskAdded(this.task);

  @override
  List<Object?> get props => [task];
}
