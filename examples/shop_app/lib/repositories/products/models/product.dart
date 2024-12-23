import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.image,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final String type;
  final double price;
  final String image;
  final bool isFavorite;

  @override
  List<Object> get props => [id, name, type, price, image, isFavorite];

  @override
  bool? get stringify => true;

  Product copyWith({
    String? id,
    String? name,
    String? type,
    double? price,
    String? image,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      price: price ?? this.price,
      image: image ?? this.image,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
