import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_shop_app_example/features/product/bloc/bloc.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final _productBloc = ProductBloc(
    productsRepository: GetIt.instance<AbstractProductsRepository>(),
  );

  String? _productId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      args as Map<String, dynamic>;
      _productId = args['productId'];
      _loadProduct();
    }
  }

  void _loadProduct() {
    if (_productId != null) {
      _productBloc.add(LoadProduct(_productId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: _productBloc,
        builder: (context, state) {
          if (state is ProductLoaded) {
            return Column(
              children: [],
            );
          }
          if (state is ProductLoadingFailure) {
            return Center(
              child: TextButton(
                onPressed: _loadProduct,
                child: const Text('Try again'),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
