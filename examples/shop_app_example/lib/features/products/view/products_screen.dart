import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_shop_app_example/features/products/bloc/products/products_bloc.dart';
import 'package:talker_shop_app_example/features/products/widgets/widgets.dart';
import 'package:talker_shop_app_example/repositories/products/products.dart';
import 'package:talker_shop_app_example/ui/ui.dart';
import 'package:talker_shop_app_example/utils/utils.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final _productsBloc = ProductsBloc(
    productsRepository: DI<AbstractProductsRepository>(),
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text(
              'SHOPY',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: false,
            surfaceTintColor: theme.cardColor,
            leading: const Icon(
              Icons.menu_rounded,
              color: Colors.black,
              size: 28,
            ),
            actions: [
              _OpenLogsButton(
                onPressed: () => _openTalkerScreen(context),
              ),
            ],
          ),
          const SliverToBoxAdapter(child: _ExampleWarning()),
          BlocBuilder<ProductsBloc, ProductsState>(
            bloc: _productsBloc,
            builder: (context, state) {
              if (state is ProductsLoaded) {
                final products = state.products;
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 12)
                      .copyWith(bottom: 40),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int i) {
                        return ProductCard(
                          product: products[i],
                          onTap: () => _openProductScreen(context, products, i),
                        );
                      },
                      childCount: products.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  ),
                );
              }
              if (state is ProductsLoadingFailure) {
                return SliverFillRemaining(
                  child: _ErrorScreen(onReload: _loadProducts),
                );
              }
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openTalkerScreen(BuildContext context) =>
      Navigator.pushNamed(context, Routes.talker);

  void _openProductScreen(BuildContext context, List<Product> products, int i) {
    Navigator.pushNamed(
      context,
      Routes.product,
      arguments: {'productId': products[i].id},
    );
  }

  void _loadProducts() {
    _productsBloc.add(LoadProducts());
  }
}

class _OpenLogsButton extends StatelessWidget {
  const _OpenLogsButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
        onPressed: onPressed,
        icon: const Icon(
          Icons.document_scanner,
          color: Colors.white,
        ),
        label: const Text(
          'Open logs',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({
    super.key,
    required this.onReload,
  });

  final VoidCallback onReload;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Ops! Something not working',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const Text(
            'It is special error to check how logs working in differend ways of logic',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: onReload,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}

class _ExampleWarning extends StatelessWidget {
  const _ExampleWarning({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange[800]!),
        borderRadius: BorderRadius.circular(15),
        color: theme.cardColor,
        boxShadow: cardShadow,
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange[800]!,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _waringText,
              style: TextStyle(color: Colors.orange[800]!),
            ),
          ),
        ],
      ),
    );
  }
}

const _waringText =
    'In this example, every second http - request will be intentionally incorrect to show all types of logs in TalkerMonitor';
