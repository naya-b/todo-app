import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class UpdateTaskUsecase {
  final TasksRepository repository;

  UpdateTaskUsecase(this.repository);

  Future<Either<Failure, Unit>> call(
    Tasks tasks,
  ) async {
    return await repository.updateTask(
      tasks,
    );
  }
}
