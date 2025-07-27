// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoLocation _$GeoLocationFromJson(Map<String, dynamic> json) => GeoLocation(
      latitude: GeoLocation._stringToDouble(json['lat'] as String),
      longitude: GeoLocation._stringToDouble(json['lng'] as String),
    );

Map<String, dynamic> _$GeoLocationToJson(GeoLocation instance) =>
    <String, dynamic>{
      'lat': GeoLocation._doubleToString(instance.latitude),
      'lng': GeoLocation._doubleToString(instance.longitude),
    };
