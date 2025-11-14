import 'package:flutter/material.dart';
import 'package:task_manager_app/features/auth/presentation/pages/admin/admin_home_page.dart';
import 'package:task_manager_app/features/auth/presentation/pages/employee/employee_home_page.dart';
import 'package:task_manager_app/features/auth/presentation/pages/login_page.dart';
import 'package:task_manager_app/features/auth/presentation/pages/manager/manager_home_page.dart';

class AppRoutes {
  static const login = "/login";
  static const adminDashboard = "/admin_dashboard";
  static const managerDashboard = "/manager_dashboard";
  static const employeeDashboard = "/employee_dashboard";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminHomePage());
      case managerDashboard:
        return MaterialPageRoute(builder: (_) => const ManagerHomePage());
      case employeeDashboard:
        return MaterialPageRoute(builder: (_) => const EmployeeHomePage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
