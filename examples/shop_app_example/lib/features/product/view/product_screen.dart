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
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        bloc: _productBloc,
        builder: (context, state) {
          if (state is ProductLoaded) {
            final product = state.product;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          stops: [-0.3, 0.9],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFF1F3F4),
                            Color(0xFFE3E4E4),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        product.image,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<ProductBloc, ProductState>(
                  bloc: _productBloc,
                  builder: (context, state) {
                    if (state is ProductLoaded) {
                      final product = state.product;
                      return Container(
                        height: 500,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400]!,
                              blurRadius: 30,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      product.type,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '${product.price} \$',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(flex: 1),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Flexible(
                                    child: Text(
                                      'Product details',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '''It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ''',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(flex: 2),
                              SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FloatingActionButton(
                                        backgroundColor: theme.primaryColor,
                                        child: Icon(
                                          Icons.favorite,
                                          color: product.isFavorite
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                        onPressed: () =>
                                            _toggleProductIsFavorite(product),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        child: SizedBox(
                                          height: 55,
                                          child: AddToCartButton(
                                            onPressed: () =>
                                                _addProductToCart(product),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _addProductToCart(Product product) {
    _productBloc.add(AddProductToCart(product.id));
  }

  void _toggleProductIsFavorite(Product product) {
    _productBloc.add(
      UpdateProduct(
        product.copyWith(isFavorite: !product.isFavorite),
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(theme.primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ),
      ),
      onPressed: onPressed,
      icon: const Padding(
        padding: EdgeInsets.only(
          right: 10.0,
        ),
        child: Icon(
          Icons.shopping_basket,
        ),
      ),
      label: Row(
        children: const [
          Text('Add to card'),
        ],
      ),
    );
  }
}
