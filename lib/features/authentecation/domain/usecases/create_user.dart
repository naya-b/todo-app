import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/authentecation/domain/entities/auth.dart';
import 'package:todo_app/features/authentecation/domain/repositories/auth_repository.dart';

class CreateUserUsecase {
  final AuthRepositories repositories;
  CreateUserUsecase(this.repositories);
  Future<Either<Failure, bool>> call(Auth auth) async {
    return await repositories.createUser(auth);
  }
}
