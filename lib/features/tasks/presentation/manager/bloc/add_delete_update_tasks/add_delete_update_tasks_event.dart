part of 'add_delete_update_tasks_bloc.dart';

abstract class AddDeleteUpdateTasksEvent extends Equatable {
  const AddDeleteUpdateTasksEvent();
}

class AddTaskEvent extends AddDeleteUpdateTasksEvent {
  final Tasks tasks;

  AddTaskEvent({required this.tasks});
  @override
  List<Object?> get props => [tasks];
}

class UpdateTaskEvent extends AddDeleteUpdateTasksEvent {
  final Tasks tasks;

  UpdateTaskEvent({
    required this.tasks,
  });
  @override
  List<Object?> get props => [tasks];
}

class DeleteTaskEvent extends AddDeleteUpdateTasksEvent {
  final String taskId;

  DeleteTaskEvent({required this.taskId});
  @override
  List<Object?> get props => [taskId];
}
