import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required AbstractProductsRepository productsRepository})
      : _productsRepository = productsRepository,
        super(ProductInitial()) {
    on<LoadProduct>(_loadProduct);
  }

  final AbstractProductsRepository _productsRepository;

  Future<void> _loadProduct(
    LoadProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      emit(ProductLoading());
      final products = await _productsRepository.getProduct(event.id);
      emit(ProductLoaded(products));
    } on Exception catch (e, st) {
      GetIt.instance<Talker>().handle(e, st);
      emit(ProductLoadingFailure());
    }
  }
}
