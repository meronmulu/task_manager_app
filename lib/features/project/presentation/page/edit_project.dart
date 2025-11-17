import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_bloc.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_event.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_state.dart';

class EditProject extends StatefulWidget {
  final int projectId;
  final String name;
  final String description;

  const EditProject({
    super.key,
    required this.projectId,
    required this.name,
    required this.description,
  });

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveProject() {
    if (_formKey.currentState!.validate()) {
      context.read<ProjectBloc>().add(
        EditProjectRequested(
          projectId: widget.projectId,
          projectName: nameController.text,
          description: descriptionController.text,
          status: "ACTIVE", // or your actual status
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Project updated successfully"),
              backgroundColor: Colors.green,
            ),
          );

          // Reload projects after update
          context.read<ProjectBloc>().add(FetchAllProject());

          Navigator.pop(context);
        }

        if (state is ProjectFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Project"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  "Project Name",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Enter project name",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Project name is required" : null,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Description",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: "Enter description",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? "Description is required" : null,
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: saveProject,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
