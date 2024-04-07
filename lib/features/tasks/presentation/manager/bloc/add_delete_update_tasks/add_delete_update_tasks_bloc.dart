import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/strings/failures.dart';
import 'package:todo_app/core/strings/messages.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';
import 'package:todo_app/features/tasks/domain/use_cases/add_task.dart';
import 'package:todo_app/features/tasks/domain/use_cases/delete_task.dart';
import 'package:todo_app/features/tasks/domain/use_cases/update_checkbox.dart';
import 'package:todo_app/features/tasks/domain/use_cases/update_task.dart';

part 'add_delete_update_tasks_event.dart';
part 'add_delete_update_tasks_state.dart';

class AddDeleteUpdateTasksBloc
    extends Bloc<AddDeleteUpdateTasksEvent, AddDeleteUpdateTasksState> {
  final AddTaskUsecase addTask;
  final UpdateTaskUsecase updateTask;
  final DeleteTaskUsecase deleteTask;
  AddDeleteUpdateTasksBloc({
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(AddDeleteUpdateTasksInitial()) {
    // ال initial state
    on<AddDeleteUpdateTasksEvent>((event, emit) async {
      if (event is AddTaskEvent) {
        emit(LoadingAddDeleteUpdateTasksState());
        final failureOrMessageDone = await addTask(event.tasks);
        print(failureOrMessageDone);
        emit(_eitherDoneMessageOrErrorState(
            failureOrMessageDone, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdateTaskEvent) {
        emit(LoadingAddDeleteUpdateTasksState());
        final failureOrMessageDone = await updateTask(
          event.tasks,
        );
        emit(_eitherDoneMessageOrErrorState(
            failureOrMessageDone, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeleteTaskEvent) {
        emit(LoadingAddDeleteUpdateTasksState());
        final failureOrMessageDone = await deleteTask(event.taskId);
        print(failureOrMessageDone);
        emit(_eitherDoneMessageOrErrorState(
            failureOrMessageDone, DELETE_SUCCESS_MESSAGE));
      }
    });
  }
  AddDeleteUpdateTasksState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorAddDeleteUpdateTasksState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageAddDeleteUpdateTasksState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
