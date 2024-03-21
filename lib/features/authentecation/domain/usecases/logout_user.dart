import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/authentecation/domain/repositories/auth_repository.dart';

class LogoutUserUsecase {
  final AuthRepositories repositories;

  LogoutUserUsecase(this.repositories);
  Future<Either<Failure, Unit>> call() async {
    return await repositories.logoutUser();
  }
}
