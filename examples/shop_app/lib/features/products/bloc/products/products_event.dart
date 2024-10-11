part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => true;
}

class LoadProducts extends ProductsEvent {}
