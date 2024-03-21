import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failures.dart';
import 'package:todo_app/features/tasks/domain/repositories/task_repository.dart';

class UpdateCheckboxUsecase {
  final TasksRepository repository;

  UpdateCheckboxUsecase(this.repository);

  Future<Either<Failure, Unit>> call(bool value, String taskId) async {
    return await repository.updateCheckbox(value, taskId);
  }
}
