import 'package:todo_app/features/authentecation/domain/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({required super.name, required super.email, required super.password});
}

class LoadedStateCheckParam {
  final bool check;
  final String email;

  LoadedStateCheckParam({
    this.check = false,
    this.email = '',
  });
}
