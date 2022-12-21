import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required AbstractProductsRepository productsRepository,
  })  : _productsRepository = productsRepository,
        super(ProductInitial()) {
    on<LoadProduct>(_loadProduct);
    on<UpdateProduct>(_updateProduct);
    on<AddProductToCart>(_addToCard);
  }

  final AbstractProductsRepository _productsRepository;

  Future<void> _loadProduct(
    LoadProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());
      final product = await _productsRepository.getProduct(event.id);
      emit(ProductLoaded(product));
    } on Exception catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      emit(ProductLoadingFailure());
    }
  }

  Future<void> _updateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await _productsRepository.addToFavorites(event.product.id);
      emit(ProductLoaded(event.product));
    } on Exception catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      // emit(ProductLoadingFailure());
    }
  }

  Future<void> _addToCard(
    AddProductToCart event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await _productsRepository.addToCart(event.id);
    } on Exception catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
    }
  }
}
