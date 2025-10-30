import 'package:task_manager_app/features/tasks/domian/entities/task_entities.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.taskId,
    required super.title,
    required super.description,
    required super.status,
    required super.priority,
    required super.projectId,
    required super.assignedToId,
    required super.dueDate,
    required super.createdAt,
    required super.updatedAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['taskId'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      priority: json['priority'],
      projectId: json['projectId'],
      assignedToId: json['assignedTo'],
      dueDate: DateTime.parse(json['dueDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "status": status,
    "priority": priority,
    "projectId": projectId,
    "assignedTo": assignedToId,
    "dueDate": dueDate.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
