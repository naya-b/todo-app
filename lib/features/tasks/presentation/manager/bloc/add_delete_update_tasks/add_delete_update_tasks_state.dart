part of 'add_delete_update_tasks_bloc.dart';

abstract class AddDeleteUpdateTasksState extends Equatable {
  const AddDeleteUpdateTasksState();
}

class AddDeleteUpdateTasksInitial extends AddDeleteUpdateTasksState {
  @override
  List<Object> get props => [];
}

class LoadingAddDeleteUpdateTasksState extends AddDeleteUpdateTasksState {
  @override
  List<Object> get props => [];
}

class ErrorAddDeleteUpdateTasksState extends AddDeleteUpdateTasksState {
  final String message;

  ErrorAddDeleteUpdateTasksState({required this.message});

  @override
  List<Object?> get props => [message];
}

class MessageAddDeleteUpdateTasksState extends AddDeleteUpdateTasksState {
  final String message;

  MessageAddDeleteUpdateTasksState({required this.message});

  @override
  List<Object?> get props => [message];
}
