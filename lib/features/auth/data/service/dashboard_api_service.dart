import 'package:dio/dio.dart';
import 'package:task_manager_app/core/networks/api_config.dart';

class DashboardService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConfig.baseUrl));

  Future<Map<String, dynamic>> getSummary(String token) async {
    final response = await _dio.get(
      "/dashboard/manager-summary",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    return response.data;
  }
}
