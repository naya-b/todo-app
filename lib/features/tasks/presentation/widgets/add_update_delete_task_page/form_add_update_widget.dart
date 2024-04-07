import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/theems/color_theme.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';
import 'package:todo_app/features/tasks/presentation/manager/bloc/add_delete_update_tasks/add_delete_update_tasks_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdate;
  final Tasks? task;

  const FormWidget({
    super.key,
    required this.isUpdate,
    this.task,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  _FormWidgetState();

  @override
  void initState() {
    if (widget.isUpdate) {
      _titleController.text = widget.task!.title;
      _bodyController.text = widget.task!.body;
    }
    super.initState();
  }

  void validateFormthenAddOrUpdateTask() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final task = Tasks(
          title: _titleController.text,
          body: _bodyController.text,
          isDone: widget.isUpdate ? widget.task!.isDone : false,
          createdBy: widget.isUpdate ? widget.task!.createdBy : '',
          id2: widget.isUpdate ? widget.task!.id2 : '');

      if (widget.isUpdate) {
        BlocProvider.of<AddDeleteUpdateTasksBloc>(context).add(UpdateTaskEvent(
          tasks: task,
        ));
      } else {
        BlocProvider.of<AddDeleteUpdateTasksBloc>(context)
            .add(AddTaskEvent(tasks: task));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _titleController,
            validator: (val) => val!.isEmpty ? "Title Can't be empty" : null,
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle:
                  TextStyle(color: widget.isUpdate ? colorblue : colororange),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorgray, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.isUpdate ? colorblue : colororange,
                    width: 2.0),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            minLines: 1,
            maxLines: 1,
          ),
          SizedBox(
            height: 8.0,
          ),
          TextFormField(
            controller: _bodyController,
            validator: (val) =>
                val!.isEmpty ? "Description Can't be empty" : null,
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle:
                  TextStyle(color: widget.isUpdate ? colorblue : colororange),
              // border: UnderlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorgray, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: widget.isUpdate ? colorblue : colororange,
                    width: 2.0),
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            minLines: 1,
            maxLines: 3,
          ),
          SizedBox(
            height: 8.0,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('cancel'),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.isUpdate ? colorblue : colororange,
              ),
            ),
            ElevatedButton.icon(
              onPressed: validateFormthenAddOrUpdateTask,
              icon: widget.isUpdate ? Icon(Icons.edit) : Icon(Icons.add),
              label: Text(widget.isUpdate ? 'Edit' : 'Add'),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.isUpdate ? colorblue : colororange,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
