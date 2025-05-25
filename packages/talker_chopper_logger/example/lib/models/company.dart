import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company with EquatableMixin {
  const Company({
    required this.name,
    required this.catchPhrase,
    required this.businessStrategy,
  });

  final String name;
  final String catchPhrase;
  @JsonKey(name: 'bs')
  final String businessStrategy;

  Company copyWith({
    String? name,
    String? catchPhrase,
    String? businessStrategy,
  }) =>
      Company(
        name: name ?? this.name,
        catchPhrase: catchPhrase ?? this.catchPhrase,
        businessStrategy: businessStrategy ?? this.businessStrategy,
      );

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  @override
  List<Object?> get props => [
        name,
        catchPhrase,
        businessStrategy,
      ];
}
