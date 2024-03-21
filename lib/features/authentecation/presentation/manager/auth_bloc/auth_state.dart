part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class LoadingState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoadedStateCheck extends AuthState {
  final LoadedStateCheckParam param;

  LoadedStateCheck(this.param);
  @override
  List<Object?> get props => [];
}

class LoadedStateLogin extends AuthState {
  final LoadedStateCheckParam param;

  LoadedStateLogin(this.param);

  @override
  List<Object?> get props => [];
}

class ErrorState extends AuthState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LoadedStateLogout extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoadedStateCreate extends AuthState {
  final bool create;

  LoadedStateCreate(this.create);
  @override
  List<Object?> get props => [];
}
