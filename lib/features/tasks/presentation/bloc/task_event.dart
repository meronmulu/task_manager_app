abstract class TaskEvent {
  @override
  List<Object?> get props => [];
}

class FetchAllTasks extends TaskEvent {}

class FetchTasksByProject extends TaskEvent {
  final int projectId;

  FetchTasksByProject(this.projectId);
}

class AddTasks extends TaskEvent {
  final String title;
  final String description;
  final String status;
  final String priority;
  final int projectId;
  final int assignedToId;
  final DateTime dueDate;

  AddTasks({
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.projectId,
    required this.assignedToId,
    required this.dueDate,
  });
}
