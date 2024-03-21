import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class DeleteTaskUsecase {
  final TasksRepository repository;

  DeleteTaskUsecase(this.repository);

  Future<Either<Failure, Unit>> call(String taskId) async {
    return await repository.deleteTask(taskId);
  }
}
