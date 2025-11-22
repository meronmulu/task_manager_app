import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/core/networks/api_config.dart';
import 'package:task_manager_app/features/tasks/data/models/task_models.dart';

class TaskServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {'Content_Type': 'application/json'},
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  Future<List<TaskModel>> getAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("Token not found. Please login first! ");
    }

    final response = await _dio.get(
      "/tasks/tasks",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    final data = response.data["data"] as List;
    return data.map((e) => TaskModel.fromJson(e)).toList();
  }

  Future<List<TaskModel>> getTasksByProject(int projectId) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");

    if (token == null) {
      throw Exception("Token not found. Please login first!");
    }

    final response = await _dio.get(
      "/tasks/project/$projectId",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    final data = response.data["data"] as List;
    return data.map((e) => TaskModel.fromJson(e)).toList();
  }

  Future<TaskModel> addTasks({
    required String title,
    required String description,
    required String status,
    required String priority,
    required int projectId,
    required int assignedToId,
    required DateTime dueDate,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      throw Exception("Token not found. Please login first!");
    }

    final response = await _dio.post(
      "/tasks/create-task",
      data: {
        "title": title,
        "description": description,
        "status": status,
        "priority": priority,
        "projectId": projectId,
        "assignedToId": assignedToId,
        "dueDate": dueDate.toIso8601String(),
      },
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      final taskJson = data is Map<String, dynamic> ? data['data'] : data;
      return TaskModel.fromJson(taskJson);
    } else {
      throw Exception("Failed to Add tasks");
    }
  }
}
