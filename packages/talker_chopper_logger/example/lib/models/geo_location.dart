import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo_location.g.dart';

@JsonSerializable()
class GeoLocation with EquatableMixin {
  const GeoLocation({
    required this.latitude,
    required this.longitude,
  });

  @JsonKey(
    name: 'lat',
    fromJson: GeoLocation._stringToDouble,
    toJson: GeoLocation._doubleToString,
  )
  final double latitude;
  @JsonKey(
    name: 'lng',
    fromJson: GeoLocation._stringToDouble,
    toJson: GeoLocation._doubleToString,
  )
  final double longitude;

  GeoLocation copyWith({
    double? latitude,
    double? longitude,
  }) =>
      GeoLocation(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  static String _doubleToString(double value) => value.toString();

  static double _stringToDouble(String value) => double.tryParse(value) ?? 0;

  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);

  @override
  List<Object?> get props => [latitude, longitude];
}
