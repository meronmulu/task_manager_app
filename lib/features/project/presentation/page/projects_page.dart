import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/project/data/repositories/project_repository_imp.dart';
import 'package:task_manager_app/features/project/data/service/project_api_services.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_bloc.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_event.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_state.dart';
import 'package:task_manager_app/features/project/presentation/page/add_project.dart';
import 'package:task_manager_app/features/project/presentation/page/edit_project.dart';
import 'package:task_manager_app/features/tasks/presentation/page/task_page.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ProjectBloc(ProjectRepositoryImp(ProjectApiService()))
            ..add(FetchAllProject()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Projects", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: BlocBuilder<ProjectBloc, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProjectFailure) {
              return Center(child: Text("Error: ${state.error}"));
            }

            if (state is ProjectsLoaded) {
              final projects = state.projects;

              if (projects.isEmpty) {
                return const Center(child: Text("No projects found."));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Search",
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: const Color.fromARGB(
                                255,
                                245,
                                245,
                                245,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 7,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<ProjectBloc>(),
                                  child: const ProjectAdd(),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Project',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          final project = projects[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                project.projectName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(project.description),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BlocProvider.value(
                                            value: context.read<ProjectBloc>(),
                                            child: EditProjectPage(
                                              projectId: project.projectId,
                                              name: project.projectName,
                                              description: project.description,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text("Delete Project"),
                                          content: const Text(
                                            "Are you sure you want to delete this project?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context.read<ProjectBloc>().add(
                                                  DeleteProjectRequested(
                                                    projectId:
                                                        project.projectId,
                                                  ),
                                                );
                                                Navigator.of(ctx).pop();
                                              },
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        TaskPage(projectId: project.projectId),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text("No projects found."));
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
