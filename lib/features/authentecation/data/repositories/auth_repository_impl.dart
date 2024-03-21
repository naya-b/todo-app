import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/exceptions.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/network/network_info.dart';
import 'package:todo_app/features/authentecation/data/datasources/auth_remote_data_source.dart';
import 'package:todo_app/features/authentecation/data/models/auth_model.dart';
import 'package:todo_app/features/authentecation/domain/entities/auth.dart';
import 'package:todo_app/features/authentecation/domain/repositories/auth_repository.dart';

typedef Future<Unit> CreateOrLoginOrLogoutAuth();

class AuthRepositoryImpl implements AuthRepositories {
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(
      {required this.networkInfo, required this.authRemoteDataSource});

  @override
  Future<Either<Failure, bool>> createUser(Auth auth) async {
    final AuthModel authModel =
        AuthModel(name: auth.name, email: auth.email, password: auth.password);
    if (await networkInfo.isConnected) {
      try {
        final user = await authRemoteDataSource.createUser(authModel);
        print('new user created $user');
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, LoadedStateCheckParam>> loginUser(Auth auth) async {
    final AuthModel authModel =
        AuthModel(name: auth.name, email: auth.email, password: auth.password);

    if (await networkInfo.isConnected) {
      try {
        final LoadedStateCheckParam user =
            await authRemoteDataSource.loginUser(authModel);
        print('user logged in $user');
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, LoadedStateCheckParam>> checkUserAuth() async {
    if (await networkInfo.isConnected) {
      try {
        final LoadedStateCheckParam check =
            await authRemoteDataSource.checkUserAuth();
        return Right(check);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logoutUser() async {
    if (await networkInfo.isConnected) {
      try {
        await authRemoteDataSource.logoutUser();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  Future<Either<Failure, Unit>> _getMessage(
      CreateOrLoginOrLogoutAuth createOrLoginOrLogoutAuth) async {
    if (await networkInfo.isConnected) {
      try {
        await createOrLoginOrLogoutAuth();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
