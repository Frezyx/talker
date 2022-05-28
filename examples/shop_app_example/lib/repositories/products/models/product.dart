import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
  });

  final String id;
  final String name;
  final String type;
  final double price;
  final String image;

  @override
  List<Object> get props => [name, type, price, image];

  @override
  bool? get stringify => true;
}
