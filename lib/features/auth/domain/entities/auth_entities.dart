class AuthEntities {
  final int userId;
  final String name;
  final String email;
  final String password;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  AuthEntities({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });
}
