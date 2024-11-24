part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  const ProductLoaded(this.product);
  final Product product;

  @override
  List<Object> get props => super.props..add(product);
}

class ProductLoadingFailure extends ProductState {}
