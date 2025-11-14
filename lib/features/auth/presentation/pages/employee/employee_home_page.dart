import 'package:flutter/material.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({super.key});

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  // Sidebar Drawer

  Widget _buildRecentProjects() {
    final projects = [
      {"name": "Website Revamp", "status": "In Progress"},
      {"name": "Mobile App UI", "status": "Completed"},
      {"name": "Marketing Tool", "status": "Pending"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text(
            "Recent Projects",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...projects.map((proj) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text(proj["name"]!),
              subtitle: Text("Status: ${proj["status"]!}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Management")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(children: [_buildRecentProjects()]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Proile"),
        ],
      ),
    );
  }
}
