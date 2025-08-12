import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class Album with EquatableMixin {
  const Album({
    this.id,
    required this.userId,
    required this.title,
  });

  final int? id;
  final int userId;
  final String title;

  Album copyWith({
    int? id,
    int? userId,
    String? title,
  }) =>
      Album(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
      );

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
      ];
}
