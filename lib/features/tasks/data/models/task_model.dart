import 'package:todo_app/features/tasks/domain/entities/tasks.dart';

class TaskModel extends Tasks {
  const TaskModel({
    required super.id,
    required super.title,
    required super.body,
    required super.isDone,
    required super.createdBy,
    required super.id2,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json, String taskId) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      isDone: json['isDone'],
      createdBy: json['createdBy'],
      id2: taskId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'isDone': isDone,
      'createdBy': createdBy,
    };
  }
}
