import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/authentecation/data/models/auth_model.dart';
import 'package:todo_app/features/authentecation/domain/entities/auth.dart';
import 'package:todo_app/features/authentecation/domain/repositories/auth_repository.dart';

class LoginUserUsecase {
  final AuthRepositories repositories;
  LoginUserUsecase(this.repositories);
  Future<Either<Failure, LoadedStateCheckParam>> call(Auth auth) async {
    //callable class
    return await repositories.loginUser(auth);
  }
}
