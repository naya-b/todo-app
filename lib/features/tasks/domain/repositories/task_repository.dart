import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';

abstract class TasksRepository {
  Future<Either<Failure, List<Tasks>>> getAllTasks();
  Future<Either<Failure, Unit>> addTask(Tasks tasks);
  Future<Either<Failure, Unit>> updateTask(
    Tasks tasks,
  );
  Future<Either<Failure, Unit>> deleteTask(String id);
  Future<Either<Failure, Unit>> updateCheckbox(bool value, String taskId);
}
