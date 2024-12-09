part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => true;
}

class LoadProduct extends ProductEvent {
  const LoadProduct(this.id);
  final String id;

  @override
  List<Object> get props => super.props..add(id);
}

class UpdateProduct extends ProductEvent {
  const UpdateProduct(this.product);
  final Product product;

  @override
  List<Object> get props => super.props..add(product);
}

class AddProductToCart extends ProductEvent {
  const AddProductToCart(this.id);
  final String id;

  @override
  List<Object> get props => super.props..add(id);
}
