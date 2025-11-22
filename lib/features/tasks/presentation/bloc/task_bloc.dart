import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/tasks/domian/repositories/task_repositories.dart';
import 'package:task_manager_app/features/tasks/presentation/bloc/task_event.dart';
import 'package:task_manager_app/features/tasks/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository repository;

  TaskBloc(this.repository) : super(TaskInitial()) {
    on<FetchAllTasks>(_onFetchAllTasks);
    on<FetchTasksByProject>(_onFetchTasksByProject);
    on<AddTasks>(_onAddTasks);
  }

  Future<void> _onFetchAllTasks(
    FetchAllTasks event,
    Emitter<TaskState> emit,
  ) async {
    emit(TaskLoading());
    try {
      final tasks = await repository.getAllTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  Future<void> _onFetchTasksByProject(
    FetchTasksByProject event,
    Emitter<TaskState> emit,
  ) async {
    try {
      final tasks = await repository.getTasksByProject(event.projectId);
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }

  Future<void> _onAddTasks(AddTasks event, Emitter<TaskState> emit) async {
    try {
      final task = await repository.addTasks(
        title: event.title,
        description: event.description,
        status: event.status,
        priority: event.priority,
        projectId: event.projectId,
        assignedToId: event.assignedToId,
        dueDate: event.dueDate,
      );
      emit(TaskAdded(task));
    } catch (e) {
      emit(TaskFailure(e.toString()));
    }
  }
}
