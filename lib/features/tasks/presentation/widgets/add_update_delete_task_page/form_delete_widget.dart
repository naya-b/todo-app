import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/add_delete_update_tasks/add_delete_update_tasks_bloc.dart';

class FormDeleteWidget extends StatelessWidget {
  final String taskId;
  const FormDeleteWidget({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              BlocProvider.of<AddDeleteUpdateTasksBloc>(context)
                  .add(DeleteTaskEvent(taskId: taskId));
            },
            child: Text('yes')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No')),
      ],
    );
  }
}
