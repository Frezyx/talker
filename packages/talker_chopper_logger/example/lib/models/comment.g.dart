// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: (json['id'] as num?)?.toInt(),
      postId: (json['postId'] as num).toInt(),
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'name': instance.name,
      'email': instance.email,
      'body': instance.body,
    };
