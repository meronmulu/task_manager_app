import 'package:task_manager_app/features/auth/domain/entities/auth_entities.dart';

abstract class AuthRepository {
  Future<AuthEntities> login(String email, String password);
  Future<List<AuthEntities>> getAllUsers();
  Future<AuthEntities> addUser({
    required String name,
    required String email,
    required String password,
    required String role,
  });
}
