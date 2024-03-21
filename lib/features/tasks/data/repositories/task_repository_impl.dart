import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/exceptions.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/core/network/network_info.dart';
import 'package:todo_app/features/tasks/data/datasources/task_local_data_source.dart';
import 'package:todo_app/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:todo_app/features/tasks/data/models/task_model.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TasksRepository {
  final TaskRemoteDataSource taskRemoteDataSource;
  final TaskLocalDataSource taskLocalDataSource;
  final NetworkInfo networkInfo;

  TaskRepositoryImpl(
      {required this.taskRemoteDataSource,
      required this.taskLocalDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<Tasks>>> getAllTasks() async {
    //هون بدنا نعرف اول اذا الجهاز فيو نت مشان نعرف نطلب التاسكات من لوكال ولا الريموت
    if (await networkInfo.isConnected) {
      try {
        print('2');
        final remoteTasks = await taskRemoteDataSource.getAllTasks();
        print('3');
        taskLocalDataSource.cacheTasks(remoteTasks);
        return Right(remoteTasks);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTasks = await taskLocalDataSource.getCachedTasks();
        return Right(localTasks);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addTask(Tasks tasks) async {
    //لازم نحول ال tasks to taskmodel
    final TaskModel taskModel = TaskModel(
        id: tasks.id,
        title: tasks.title,
        body: tasks.body,
        isDone: tasks.isDone,
        createdBy: tasks.createdBy,
        id2: tasks.id2);
    if (await networkInfo.isConnected) {
      try {
        await taskRemoteDataSource.addTask(taskModel);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure()); // or left() ??? l صغيرة
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTask(
    Tasks tasks,
  ) async {
    final TaskModel taskModel = TaskModel(
        id: tasks.id,
        title: tasks.title,
        body: tasks.body,
        isDone: tasks.isDone,
        createdBy: tasks.createdBy,
        id2: tasks.id2);
    if (await networkInfo.isConnected) {
      try {
        await taskRemoteDataSource.updateTask(
          taskModel,
        );
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(String taskId) async {
    if (await networkInfo.isConnected) {
      try {
        await taskRemoteDataSource.deleteTask(taskId);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCheckbox(
      bool value, String taskId) async {
    if (await networkInfo.isConnected) {
      try {
        await taskRemoteDataSource.updateCheckbox(value, taskId);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
// معالجة تكرار الكود
