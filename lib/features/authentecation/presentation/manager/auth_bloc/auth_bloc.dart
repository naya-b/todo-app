import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/strings/failures.dart';
import 'package:todo_app/features/authentecation/data/models/auth_model.dart';
import 'package:todo_app/features/authentecation/domain/entities/auth.dart';
import 'package:todo_app/features/authentecation/domain/usecases/check_user_auth.dart';
import 'package:todo_app/features/authentecation/domain/usecases/create_user.dart';
import 'package:todo_app/features/authentecation/domain/usecases/login_user.dart';
import 'package:todo_app/features/authentecation/domain/usecases/logout_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateUserUsecase createUserUsecase;
  final LoginUserUsecase loginUserUsecase;
  final CheckUserUsecase checkUserUsecase;
  final LogoutUserUsecase logoutUserUsecase;
  AuthBloc(
      {required this.createUserUsecase,
      required this.loginUserUsecase,
      required this.checkUserUsecase,
      required this.logoutUserUsecase})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is CreateUserEvent) {
        emit(LoadingState());
        final failureOrDoneMessage = await createUserUsecase(event.auth);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorState(message: _mapFailureToMessage(failure)));
        }, (bool) {
          emit(LoadedStateCreate(bool));
        });
      } else if (event is LoginUserEvent) {
        emit(LoadingState());
        final failureOrDoneMessage = await loginUserUsecase(event.auth);
        failureOrDoneMessage.fold((failure) {
          emit(ErrorState(message: _mapFailureToMessage(failure)));
        }, (bool) {
          //TODO: Here is what I changed
          // BlocProvider.of<TasksBloc>(context).add(GetAllTasksEvent(event.auth.email));
          emit(LoadedStateLogin(
              LoadedStateCheckParam(check: bool.check, email: bool.email)));
          //event.onSuccess?.call();
        });
      } else if (event is CheckUserEvent) {
        print('cheeek');
        emit(LoadingState());
        final failureOrbool = await checkUserUsecase.call();
        failureOrbool.fold((failure) {
          emit(ErrorState(message: _mapFailureToMessage(failure)));
        }, (bool) {
          emit(LoadedStateCheck(
              LoadedStateCheckParam(check: bool.check, email: bool.email)));
        });
      } else if (event is logoutUserEvent) {
        emit(LoadingState());
        final failureOrDoneMessage = await logoutUserUsecase();
        failureOrDoneMessage.fold((failure) {
          emit(ErrorState(message: _mapFailureToMessage(failure)));
        }, (unit) {
          //emit(LoadedStateLogout());
          event.onSuccess?.call();
        });
      }
    });
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
