import 'package:equatable/equatable.dart';

class Tasks extends Equatable {
  final String title;
  final String body;
  final bool? isDone;
  final String createdBy;
  final String id2;
  const Tasks({
    required this.title,
    required this.body,
    required this.isDone,
    required this.createdBy,
    required this.id2,
  });
  @override
  List<Object?> get props => [title, body, isDone, createdBy];
}
