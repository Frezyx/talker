import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment with EquatableMixin {
  const Comment({
    this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  final int? id;
  final int postId;
  final String name;
  final String email;
  final String body;

  Comment copyWith({
    int? id,
    int? postId,
    String? name,
    String? email,
    String? body,
  }) =>
      Comment(
        id: id ?? this.id,
        postId: postId ?? this.postId,
        name: name ?? this.name,
        email: email ?? this.email,
        body: body ?? this.body,
      );

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

  @override
  List<Object?> get props => [
        id,
        postId,
        name,
        email,
        body,
      ];
}
