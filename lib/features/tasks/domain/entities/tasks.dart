import 'package:equatable/equatable.dart';

class Tasks extends Equatable {
  final int id;
  final String title;
  final String body;
  final bool? isDone;
  final String createdBy;
  final String id2;
  const Tasks({
    required this.id,
    required this.title,
    required this.body,
    required this.isDone,
    required this.createdBy,
    required this.id2,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [id, title, body, isDone, createdBy];
}
