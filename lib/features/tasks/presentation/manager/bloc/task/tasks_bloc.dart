import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/strings/failures.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';
import 'package:todo_app/features/tasks/domain/use_cases/get_all_tasks.dart';
import 'package:todo_app/features/tasks/domain/use_cases/update_checkbox.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetAllTasksUsecase getAllTasksUsecases;
  final UpdateCheckboxUsecase updateCheckbox;
  TasksBloc({required this.getAllTasksUsecases, required this.updateCheckbox})
      : super(TasksInitial()) {
    on<TasksEvent>((event, emit) async {
      print('event called');
      print(event);
      if (event is GetAllTasksEvent) {
        // رح نحكي مع ال usecase مشان هيك اخدنا اوبجيكت منا
        print('55');
        emit(LoadingTasksState());
        final failureOrTasks =
            await getAllTasksUsecases(); //هي احتمال ترجعلي failure واحتمال اترجع list عن طريق ال fold بقدر اعرف شو رجعت
        failureOrTasks.fold((failure) {
          emit(ErrorTasksState(message: _mapFailureToMessage(failure)));
        }, (tasks) {
          emit(LoadedTasksState(tasks: tasks));
        });
      } else if (event is UpdateCheckboxEvent) {
        final checkbox = await updateCheckbox(event.value, event.taskId);
        emit(CheckboxState());
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
