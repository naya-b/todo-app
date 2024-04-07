import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/theems/color_theme.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/task/tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/pages/add_update_delete_task_page.dart';

class TaskListWidget extends StatefulWidget {
  final List<Tasks> tasks;

  const TaskListWidget({super.key, required this.tasks});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                color: colorblue,
              ),
              child: ListTile(
                leading: Checkbox(
                  onChanged: (bool? value) {
                    BlocProvider.of<TasksBloc>(context).add(UpdateCheckboxEvent(
                        value: value!, taskId: widget.tasks[index].id2));
                  },
                  value: widget.tasks[index].isDone,
                  activeColor: colororange,
                ),
                title: Text(
                  widget.tasks[index].title.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AddUpdateDeleteTaskPage(
                      isUpdate: false,
                      isDelete: true,
                      task: widget.tasks[index],
                    ),
                  ),
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: colorgray,
                ),
                subtitle: Text(
                  widget.tasks[index].body.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AddUpdateDeleteTaskPage(
                      isUpdate: true,
                      task: widget.tasks[index],
                      isDelete: false),
                ),
              ),
            ),
          );
        });
  }
}
