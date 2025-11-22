import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_app/features/auth/data/service/dashboard_api_service.dart';
import 'package:task_manager_app/features/auth/presentation/pages/login_page.dart';
import 'package:task_manager_app/features/auth/presentation/pages/users_page.dart';
import 'package:task_manager_app/features/project/data/model/project_model.dart';
import 'package:task_manager_app/features/project/data/service/project_api_services.dart';
import 'package:task_manager_app/features/project/presentation/page/projects_page.dart';
import 'package:task_manager_app/features/tasks/presentation/page/task_page.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key});

  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  int totalProjects = 0;
  int totalTasks = 0;
  bool loadingSummary = true;

  List<ProjectModel> projects = [];
  bool loadingProjects = true;

  @override
  void initState() {
    super.initState();
    fetchSummary();
    fetchProjects();
  }

  void fetchSummary() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final data = await DashboardService().getSummary(token!);

      setState(() {
        totalProjects = data["totalProjects"];
        totalTasks = data["totalTasks"];
        loadingSummary = false;
      });
    } catch (e) {
      print("Summary load error: $e");
    }
  }

  void fetchProjects() async {
    try {
      final data = await ProjectApiService().getAllProject();
      setState(() {
        projects = data;
        loadingProjects = false;
      });
    } catch (e) {
      print("Project load error: $e");
    }
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.admin_panel_settings, color: Colors.white, size: 40),
                SizedBox(height: 8),
                Text(
                  "Manager Menu",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text("Projects"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProjectsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text("Tasks"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TaskPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    if (loadingSummary) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCard("Projects", "$totalProjects", Icons.folder, Colors.green),
        _buildCard("Tasks", "$totalTasks", Icons.task, Colors.orange),
      ],
    );
  }

  Widget _buildCard(String title, String count, IconData icon, Color color) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(count, style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsList() {
    if (loadingProjects) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const Text(
          "Projects",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        ...projects.map((project) {
          return Card(
            elevation: 3,
            child: ListTile(
              title: Text(project.projectName),
              subtitle: Text(project.description),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskPage(projectId: project.projectId),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manager Dashboard",
          style: TextStyle(color: Colors.white),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildSummaryCards(),
            const SizedBox(height: 20),
            _buildProjectsList(),
          ],
        ),
      ),
    );
  }
}
