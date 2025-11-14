import 'package:task_manager_app/features/project/domain/entities/project_entities.dart';

class ProjectModel extends ProjectEntities {
  ProjectModel({
    required super.projectId,
    required super.projectName,
    required super.description,
    required super.status,
    required super.createdById,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json['projectId'],
      projectName: json['projectName'],
      description: json['description'],
      status: json['status'],
      createdById: json['createdById'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
    "projectId": projectId,
    "projectName": projectName,
    "description": description,
    "status": status,
    "createdById": createdById,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
