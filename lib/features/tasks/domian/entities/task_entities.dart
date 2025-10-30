class TaskEntity {
  final int taskId;
  final String title;
  final String? description;
  final String status;
  final String priority;
  final int projectId;
  final int assignedToId;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TaskEntity({
    required this.taskId,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
    required this.projectId,
    required this.assignedToId,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });
}
