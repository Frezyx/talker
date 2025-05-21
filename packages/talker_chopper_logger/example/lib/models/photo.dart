import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo with EquatableMixin {
  const Photo({
    this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  final int? id;
  final int albumId;
  final String title;
  final Uri url;
  final Uri thumbnailUrl;

  Photo copyWith({
    int? id,
    int? albumId,
    String? title,
    Uri? url,
    Uri? thumbnailUrl,
  }) =>
      Photo(
        id: id ?? this.id,
        albumId: albumId ?? this.albumId,
        title: title ?? this.title,
        url: url ?? this.url,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);

  @override
  List<Object?> get props => [
        id,
        albumId,
        title,
        url,
        thumbnailUrl,
      ];
}
