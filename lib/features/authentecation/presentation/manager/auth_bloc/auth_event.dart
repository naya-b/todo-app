part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CreateUserEvent extends AuthEvent {
  final Auth auth;
  CreateUserEvent({required this.auth});

  @override
  List<Object?> get props => [auth];
}

class LoginUserEvent extends AuthEvent {
  final Auth auth;

  //final VoidCallback? onSuccess;
  LoginUserEvent({required this.auth});

  @override
  List<Object?> get props => [auth];
}

class CheckUserEvent extends AuthEvent {}

class logoutUserEvent extends AuthEvent {
  final VoidCallback? onSuccess;

  logoutUserEvent({this.onSuccess});
}
