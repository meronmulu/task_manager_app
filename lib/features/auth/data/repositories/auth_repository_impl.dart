import 'package:task_manager_app/features/auth/data/models/auth_model.dart';
import 'package:task_manager_app/features/auth/data/service/auth_api_service.dart';
import 'package:task_manager_app/features/auth/domain/entities/auth_entities.dart';
import 'package:task_manager_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService remoteService;

  AuthRepositoryImpl(this.remoteService);

  @override
  Future<AuthEntities> login(String email, String password) async {
    final result = await remoteService.login(email, password);

    if (result["success"] == true) {
      return AuthModel.fromJson(
        result["user"]..addAll({"token": result["token"]}),
      );
    } else {
      throw Exception(result["message"] ?? "Login failed");
    }
  }

  @override
  Future<List<AuthEntities>> getAllUsers() async {
    try {
      final List<AuthModel> users = await remoteService.getAllUsers();
      return users;
    } catch (e) {
      throw Exception("Repository error: $e");
    }
  }

  @override
  Future<AuthEntities> addUser({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final AuthModel user = await remoteService.addUser(
        name: name,
        email: email,
        password: password,
        role: role,
      );
      return user;
    } catch (e) {
      throw Exception("Repository error (addUser): $e");
    }
  }
}
