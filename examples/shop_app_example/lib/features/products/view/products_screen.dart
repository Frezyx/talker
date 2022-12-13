import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/features/products/bloc/products/products_bloc.dart';
import 'package:talker_shop_app_example/features/products/widgets/widgets.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';
import 'package:talker_shop_app_example/ui/ui.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _productsBloc = ProductsBloc(
    productsRepository: GetIt.instance<AbstractProductsRepository>(),
  );

  @override
  void initState() {
    _loadProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SHOPY',
          style: TextStyle(
            color: theme.primaryColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Icon(
          Icons.menu,
          color: theme.primaryColor,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () => _openTalekrScreen(context),
              icon: const Icon(
                Icons.document_scanner,
              ),
              label: const Text('Open logs'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const ExampleWarning(
            text:
                'In this example, every second http - request will be intentionally incorrect to show all types of logs in TalkerMonitor',
          ),
          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              bloc: _productsBloc,
              builder: (context, state) {
                if (state is ProductsLoaded) {
                  final products = state.products;
                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: products.length,
                    itemBuilder: (context, i) => ProductCard(
                      product: products[i],
                      onTap: () => _openProductScreen(context, products, i),
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  );
                }
                if (state is ProductsLoadingFailure) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Ops! Something not working',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const Text(
                          'It is special error to check how logs working in differend ways of logic',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: _loadProducts,
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  void _openTalekrScreen(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.talker,
    );
  }

  void _openProductScreen(BuildContext context, List<Product> products, int i) {
    Navigator.pushNamed(
      context,
      Routes.product,
      arguments: {
        'productId': products[i].id,
      },
    );
  }

  void _loadProducts() {
    _productsBloc.add(LoadProducts());
  }
}

class ExampleWarning extends StatelessWidget {
  const ExampleWarning({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: LogLevel.warning.color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: LogLevel.warning.color,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: LogLevel.warning.color),
            ),
          ),
        ],
      ),
    );
  }
}
