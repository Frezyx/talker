// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'broken_article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrokenArticle _$BrokenArticleFromJson(Map<String, dynamic> json) =>
    BrokenArticle(
      id: json['id'] as String?,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$BrokenArticleToJson(BrokenArticle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'userId': instance.userId,
    };
