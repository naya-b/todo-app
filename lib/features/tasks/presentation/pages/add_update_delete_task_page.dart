import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/theems/color_theme.dart';
import 'package:todo_app/core/util/snackbar_message.dart';
import 'package:todo_app/core/widgets/loading_widget.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/add_delete_update_tasks/add_delete_update_tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/task/tasks_bloc.dart';
import 'package:todo_app/features/tasks/presentation/pages/tasks_page.dart';
import 'package:todo_app/features/tasks/presentation/widgets/add_update_delete_task_page/form_delete_widget.dart';
import 'package:todo_app/features/tasks/presentation/widgets/add_update_delete_task_page/form_add_update_widget.dart';

class AddUpdateDeleteTaskPage extends StatelessWidget {
  final bool isUpdate;
  final Tasks? task;
  final bool isDelete;
  const AddUpdateDeleteTaskPage(
      {super.key, required this.isUpdate, this.task, required this.isDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isUpdate
                ? 'Update Task'
                : isDelete
                    ? 'Are you sure?'
                    : 'Add Task',
            style: TextStyle(fontSize: 25.0, color: colorgray),
          ),
          SizedBox(
            height: 8.0,
          ),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: BlocConsumer<AddDeleteUpdateTasksBloc, AddDeleteUpdateTasksState>(
          listener: (context, state) {
        if (state is MessageAddDeleteUpdateTasksState) {
          SnackBarMessage()
              .showSuccessSnackBar(message: state.message, context: context);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => TasksPage()), (route) => false);
          print('here will return getalltask');
          BlocProvider.of<TasksBloc>(context).add(GetAllTasksEvent());
        } else if (state is ErrorAddDeleteUpdateTasksState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      }, builder: (context, state) {
        if (state is LoadingAddDeleteUpdateTasksState) {
          return LoadingWidget();
        }
        if (isDelete) {
          return FormDeleteWidget(
            taskId: task!.id2,
          );
        } else {
          return FormWidget(isUpdate: isUpdate, task: isUpdate ? task : null);
        }
      }),
    );
  }
}
