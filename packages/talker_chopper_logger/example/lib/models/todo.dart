import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class Todo with EquatableMixin {
  const Todo({
    this.id,
    required this.userId,
    required this.title,
    required this.completed,
  });

  final int? id;
  final int userId;
  final String title;
  final bool completed;

  Todo copyWith({
    int? id,
    int? userId,
    String? title,
    bool? completed,
  }) =>
      Todo(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        completed: completed ?? this.completed,
      );

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        completed,
      ];
}
