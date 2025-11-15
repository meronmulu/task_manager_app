import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/core/networks/app_routes.dart';
import 'package:task_manager_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:task_manager_app/features/auth/data/service/auth_api_service.dart';
import 'package:task_manager_app/features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  final authRepository = AuthRepositoryImpl(AuthApiService());

  runApp(
    BlocProvider(create: (_) => AuthBloc(authRepository), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager App',
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
