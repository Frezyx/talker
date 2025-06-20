import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@JsonSerializable()
class Article with EquatableMixin {
  const Article({
    this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  final int? id;
  final String title;
  final String body;
  final int userId;

  Article copyWith({
    int? id,
    String? title,
    String? body,
    int? userId,
  }) =>
      Article(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        userId: userId ?? this.userId,
      );

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        body,
        userId,
      ];
}
