import 'package:dio/dio.dart';
import 'package:task_manager_app/core/networks/api_config.dart';
import 'package:task_manager_app/features/auth/data/models/auth_model.dart';

class AuthApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<AuthModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final userJson = data['data'];
        final token = data['token'];

        final user = AuthModel.fromJson(userJson);

        return user;
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          "Login failed: ${e.response?.data['message'] ?? e.response?.statusMessage}",
        );
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }

  Future<List<AuthModel>> getAllUsers() async {
    try {
      final response = await _dio.get('/users/all-users');

      if (response.statusCode == 200) {
        final data = response.data;

        // Check if it's a Map (like {"success":true,"data":[...]})
        final List<dynamic> usersList = data is Map<String, dynamic>
            ? data['data']
            : data;

        return usersList.map((u) => AuthModel.fromJson(u)).toList();
      } else {
        throw Exception("Failed to fetch users: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          "Failed: ${e.response?.data['message'] ?? e.response?.statusMessage}",
        );
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }

  Future<AuthModel> addUser({
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await _dio.post(
        '/users/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;
        final userJson = data is Map<String, dynamic> ? data['data'] : data;
        return AuthModel.fromJson(userJson);
      } else {
        throw Exception("Failed to add user: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          "Failed: ${e.response?.data['message'] ?? e.response?.statusMessage}",
        );
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }
}
