part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();
}

class TasksInitial extends TasksState {
  @override
  List<Object> get props => [];
}

class LoadingTasksState extends TasksState {
  @override
  List<Object?> get props => [];
}

class LoadedTasksState extends TasksState {
  final List<Tasks> tasks;

  LoadedTasksState({required this.tasks});
  @override
  List<Object?> get props => [tasks];
}

class ErrorTasksState extends TasksState {
  final String message;

  ErrorTasksState({required this.message});
  @override
  List<Object?> get props => [message];
}

class CheckboxState extends TasksState {
  @override
  List<Object?> get props => [];
}
