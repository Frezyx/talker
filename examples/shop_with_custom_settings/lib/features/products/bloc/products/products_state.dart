part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded(this.products);
  final List<Product> products;

  @override
  List<Object> get props => super.props..add(products);

  @override
  bool? get stringify => true;
}

class ProductsLoadingFailure extends ProductsState {}
