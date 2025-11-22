import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/core/networks/api_config.dart';
import 'package:task_manager_app/features/project/data/model/project_model.dart';

class ProjectApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<List<ProjectModel>> getAllProject() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("Token not found. Please login first!");
    }

    final response = await _dio.get(
      "/projects/projects",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    final data = response.data["data"] as List;
    return data.map((e) => ProjectModel.fromJson(e)).toList();
  }

  Future<ProjectModel> addProject({
    required String projectName,
    required String description,
    required String status,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("Token not found. Please login first!");
    }

    final response = await _dio.post(
      "/projects/create-project",
      data: {
        "project_name": projectName,
        "description": description,
        "status": status,
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = response.data;
      final ProjectJson = data is Map<String, dynamic> ? data['data'] : data;
      return ProjectModel.fromJson(ProjectJson);
    } else {
      throw Exception("Failed to add user: ${response.statusMessage}");
    }
  }

  Future<ProjectModel> editProject({
    required int projectId,
    required String projectName,
    required String description,
    required String status,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("Token not found. Please login first!");
    }

    final response = await _dio.put(
      "/projects/update-project/$projectId",
      data: {
        "project_name": projectName,
        "description": description,
        "status": status,
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final ProjectJson = data is Map<String, dynamic> ? data['data'] : data;
      return ProjectModel.fromJson(ProjectJson);
    } else {
      throw Exception("Failed to edit project: ${response.statusMessage}");
    }
  }

  Future<void> deleteProject({required int projectId}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("Token not found. Please login first!");
    }

    final response = await _dio.delete(
      "/projects/delete-project/$projectId",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to delete project: ${response.statusMessage}");
    }
  }
}
