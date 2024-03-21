import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/authentecation/data/models/auth_model.dart';
import 'package:todo_app/features/authentecation/domain/repositories/auth_repository.dart';

class CheckUserUsecase {
  final AuthRepositories repositories;

  CheckUserUsecase(this.repositories);
  Future<Either<Failure, LoadedStateCheckParam>> call() async {
    return await repositories.checkUserAuth();
  }
}
