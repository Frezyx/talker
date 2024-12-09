import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';
import 'package:talker_shop_app_example/utils/utils.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({required AbstractProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(ProductsInitial()) {
    on<LoadProducts>(_loadProducts);
  }

  final AbstractProductsRepository _productsRepository;

  Future<void> _loadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      emit(ProductsLoading());
      final products = await _productsRepository.getProductsList();
      emit(ProductsLoaded(products));
    } on Exception catch (e, st) {
      DI<Talker>().handle(e, st);
      emit(ProductsLoadingFailure());
    }
  }
}
