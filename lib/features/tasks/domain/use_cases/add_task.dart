import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/tasks/domain/entities/tasks.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class AddTaskUsecase {
  final TasksRepository repository;

  AddTaskUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Tasks tasks) async {
    return await repository.addTask(tasks);
  }
}
