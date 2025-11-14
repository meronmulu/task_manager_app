class ProjectEntities {
  final int projectId;
  final String projectName;
  final String description;
  final String status;
  final int createdById;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProjectEntities({
    required this.projectId,
    required this.projectName,
    required this.description,
    required this.status,
    required this.createdById,
    required this.createdAt,
    required this.updatedAt,
  });
}
