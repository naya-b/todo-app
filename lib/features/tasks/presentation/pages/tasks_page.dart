import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/theems/color_theme.dart';
import 'package:todo_app/core/widgets/loading_widget.dart';
import 'package:todo_app/features/authentecation/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:todo_app/features/authentecation/presentation/pages/splash_page.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/task/tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/pages/add_update_delete_task_page.dart';
import 'package:todo_app/features/tasks/presentation/widgets/taskspage/message_display_widget.dart';
import 'package:todo_app/features/tasks/presentation/widgets/taskspage/task_list_widget.dart';

class TasksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Todo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: colorgray,
        actions: [
          PopupMenuButton(
              // color: colororange,
              onSelected: (val) {
                if (val == 'Logout') {
                  BlocProvider.of<AuthBloc>(context).add(
                    logoutUserEvent(onSuccess: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SplashPage()),
                      );
                    }),
                  );
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(
                        'Logout',
                        style: TextStyle(color: colorgray),
                      ),
                      value: 'Logout',
                    ),
                  ]),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: _buildFloatingBtn(context),
    );
  }
}

Widget _buildFloatingBtn(BuildContext context) {
  return FloatingActionButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    onPressed: () => showDialog(
      context: context,
      builder: (context) =>
          AddUpdateDeleteTaskPage(isUpdate: false, isDelete: false),
    ),
    child: Icon(Icons.add),
    backgroundColor: colororange,
  );
}

Widget _buildBody() {
  return Padding(
    padding: EdgeInsets.all(10),
    child: BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        if (state is LoadingTasksState) {
          return LoadingWidget();
        } else if (state is LoadedTasksState) {
          return TaskListWidget(tasks: state.tasks);
        } else if (state is ErrorTasksState) {
          return MessageDisplayWidget(message: state.message);
        } else if (state is CheckboxState) {
          print('state');
          BlocProvider.of<TasksBloc>(context).add(GetAllTasksEvent());
        }
        return LoadingWidget();
      },
    ),
  );
}
