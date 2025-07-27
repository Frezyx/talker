import 'package:equatable/equatable.dart';
import 'package:example/models/geo_location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable(explicitToJson: true)
class Address with EquatableMixin {
  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipCode,
    required this.geoLocation,
  });

  final String street;
  final String suite;
  final String city;
  @JsonKey(name: 'zipcode')
  final String zipCode;
  @JsonKey(name: 'geo')
  final GeoLocation geoLocation;

  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipCode,
    GeoLocation? geoLocation,
  }) =>
      Address(
        street: street ?? this.street,
        suite: suite ?? this.suite,
        city: city ?? this.city,
        zipCode: zipCode ?? this.zipCode,
        geoLocation: geoLocation ?? this.geoLocation,
      );

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  List<Object?> get props => [
        street,
        suite,
        city,
        zipCode,
        geoLocation,
      ];
}
