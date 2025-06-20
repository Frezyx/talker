import 'package:equatable/equatable.dart';
import 'package:example/models/address.dart';
import 'package:example/models/company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User with EquatableMixin {
  const User({
    this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  final int? id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    Address? address,
    String? phone,
    String? website,
    Company? company,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        website: website ?? this.website,
        company: company ?? this.company,
      );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        address,
        phone,
        website,
        company,
      ];
}
