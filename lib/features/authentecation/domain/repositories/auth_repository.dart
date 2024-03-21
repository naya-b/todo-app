import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/authentecation/data/models/auth_model.dart';
import 'package:todo_app/features/authentecation/domain/entities/auth.dart';

abstract class AuthRepositories {
  Future<Either<Failure, bool>> createUser(Auth auth); //signup
  Future<Either<Failure, LoadedStateCheckParam>> loginUser(Auth auth);
  Future<Either<Failure, Unit>> logoutUser();
  Future<Either<Failure, LoadedStateCheckParam>> checkUserAuth();
}
