import 'package:flutter/material.dart';
import 'package:task_manager_app/features/auth/presentation/pages/admin/admin_home_page.dart';
import 'package:task_manager_app/features/auth/presentation/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager App',
      home: AdminHomePage(),
    );
  }
}
