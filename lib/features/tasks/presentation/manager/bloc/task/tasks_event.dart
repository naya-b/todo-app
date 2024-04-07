part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();
}

class GetAllTasksEvent extends TasksEvent {
  @override
  List<Object?> get props => [];
}

class RefreshTasksEvent extends TasksEvent {
  final String email;

  RefreshTasksEvent(this.email);

  @override
  List<Object?> get props => [];
}

class UpdateCheckboxEvent extends TasksEvent {
  final bool value;
  final String taskId;

  UpdateCheckboxEvent({required this.value, required this.taskId});
  @override
  List<Object?> get props => [value, taskId];
}
