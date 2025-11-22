import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_bloc.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_event.dart';
import 'package:task_manager_app/features/project/presentation/bloc/project_state.dart';

class EditProjectPage extends StatefulWidget {
  final int projectId;
  final String name;
  final String description;

  const EditProjectPage({
    super.key,
    required this.projectId,
    required this.name,
    required this.description,
  });

  @override
  State<EditProjectPage> createState() => _EditProjectPageState();
}

class _EditProjectPageState extends State<EditProjectPage> {
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

  void _updateProject() {
    if (_formKey.currentState!.validate()) {
      context.read<ProjectBloc>().add(
        EditProjectRequested(
          projectId: widget.projectId,
          projectName: nameController.text,
          description: descriptionController.text,
          status: "COMPLETED",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectBloc, ProjectState>(
      listener: (context, state) {
        if (state is ProjectSuccess) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Project Updated Successfully")),
          );

          // Refresh project list
          context.read<ProjectBloc>().add(FetchAllProject());

          Navigator.pop(context); // Go back to project list
        } else if (state is ProjectFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${state.error}")));
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
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Project Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateProject,
                    child: const Text("Save Changes"),
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
