import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'broken_article.g.dart';

@JsonSerializable()
class BrokenArticle with EquatableMixin {
  const BrokenArticle({
    this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  // should be `int?` but we want to test the error
  final String? id;
  final String title;
  final String body;
  // should be `int` but we want to test the error
  final String userId;

  BrokenArticle copyWith({
    String? id,
    String? title,
    String? body,
    String? userId,
  }) =>
      BrokenArticle(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        userId: userId ?? this.userId,
      );

  factory BrokenArticle.fromJson(Map<String, dynamic> json) =>
      _$BrokenArticleFromJson(json);

  Map<String, dynamic> toJson() => _$BrokenArticleToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        userId,
      ];
}
