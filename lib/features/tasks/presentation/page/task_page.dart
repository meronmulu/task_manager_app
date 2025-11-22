import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/tasks/data/repositories/task_repositories_imp.dart';
import 'package:task_manager_app/features/tasks/data/servies/task_services.dart';
import 'package:task_manager_app/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_manager_app/features/tasks/presentation/bloc/task_event.dart';
import 'package:task_manager_app/features/tasks/presentation/bloc/task_state.dart';
import 'package:task_manager_app/features/tasks/presentation/page/add_task.dart';
import 'package:task_manager_app/features/tasks/presentation/page/edit_task.dart';

class TaskPage extends StatefulWidget {
  final int? projectId;

  const TaskPage({super.key, this.projectId});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = TaskBloc(TaskRepositoryImp(TaskServices()));

        if (widget.projectId == null) {
          bloc.add(FetchAllTasks());
        } else {
          bloc.add(FetchTasksByProject(widget.projectId!));
        }

        return bloc;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.projectId == null ? "All Tasks" : "Project Tasks",
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is TaskFailure) {
              return Center(child: Text("Error: ${state.error}"));
            }

            if (state is TasksLoaded) {
              final tasks = state.tasks;

              if (tasks.isEmpty) {
                return const Center(child: Text("No tasks found."));
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
                                  value: context.read<TaskBloc>(),
                                  child: const AddTask(),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.add, color: Colors.white),
                          label: const Text(
                            'Task',
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
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final item = tasks[index];

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
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(item.description ?? ''),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Text(
                                        item.status,
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        item.priority,
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => const EditTask(),
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
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
