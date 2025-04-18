// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      id: (json['id'] as num?)?.toInt(),
      albumId: (json['albumId'] as num).toInt(),
      title: json['title'] as String,
      url: Uri.parse(json['url'] as String),
      thumbnailUrl: Uri.parse(json['thumbnailUrl'] as String),
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'id': instance.id,
      'albumId': instance.albumId,
      'title': instance.title,
      'url': instance.url.toString(),
      'thumbnailUrl': instance.thumbnailUrl.toString(),
    };
