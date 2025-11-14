import 'package:dio/dio.dart';
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

  // Get all projects (requires token)
  Future<List<ProjectModel>> getAllProject(String token) async {
    try {
      final response = await _dio.get(
        '/projects',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Backend wraps projects in 'data' field
        final List<dynamic> projectList =
            data is Map<String, dynamic> && data.containsKey('data')
            ? data['data']
            : data;

        return projectList.map((p) => ProjectModel.fromJson(p)).toList();
      } else {
        throw Exception("Failed to fetch projects: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final message = e.response?.data is Map
            ? e.response?.data['message'] ?? e.response?.statusMessage
            : e.response?.statusMessage;
        throw Exception("Failed: $message");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    }
  }
}
