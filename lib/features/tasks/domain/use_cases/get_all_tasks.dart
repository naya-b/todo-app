import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class GetAllTasksUsecase {
  final TasksRepository repository;

  GetAllTasksUsecase(this.repository);

  Future<Either<Failure, List<Tasks>>> call() async {
    return await repository.getAllTasks();
  }
}
