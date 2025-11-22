import 'package:flutter/material.dart';
import 'package:task_manager_app/features/auth/presentation/pages/admin/admin_home_page.dart';
import 'package:task_manager_app/features/auth/presentation/pages/employee/employee_home_page.dart';
import 'package:task_manager_app/features/auth/presentation/pages/login_page.dart';
import 'package:task_manager_app/features/auth/presentation/pages/manager/manager_home_page.dart';
import 'package:task_manager_app/features/auth/presentation/pages/users_add.dart';
import 'package:task_manager_app/features/auth/presentation/pages/users_page.dart';
import 'package:task_manager_app/features/project/presentation/page/add_project.dart';
import 'package:task_manager_app/features/project/presentation/page/edit_project.dart';
import 'package:task_manager_app/features/project/presentation/page/projects_page.dart';
import 'package:task_manager_app/features/tasks/presentation/page/add_task.dart';
import 'package:task_manager_app/features/tasks/presentation/page/edit_task.dart';
import 'package:task_manager_app/features/tasks/presentation/page/task_page.dart';

class AppRoutes {
  static const login = "/login";
  static const adminDashboard = "/admin_dashboard";
  static const managerDashboard = "/manager_dashboard";
  static const employeeDashboard = "/employee_dashboard";
  static const users = "/users";
  static const addUser = "/add_user";
  static const editUser = "/edit_user";
  static const project = "/projects";
  static const addProject = "/add_project";
  static const editProject = "/edit_project";
  static const task = "/tasks";
  static const addTask = "/add_task";
  static const editTask = "/edit_task";

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

      case users:
        return MaterialPageRoute(builder: (_) => const UsersPage());

      case addUser:
        return MaterialPageRoute(builder: (_) => const UsersAdd());
      case editUser:
        return MaterialPageRoute(builder: (_) => const UsersAdd());
      case project:
        return MaterialPageRoute(builder: (_) => const ProjectsPage());
      case addProject:
        return MaterialPageRoute(builder: (_) => const ProjectAdd());

      case task:
        return MaterialPageRoute(builder: (_) => const TaskPage());
      case addTask:
        return MaterialPageRoute(builder: (_) => const AddTask());
      case editTask:
        return MaterialPageRoute(builder: (_) => const EditTask());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No route defined"))),
        );
    }
  }
}
