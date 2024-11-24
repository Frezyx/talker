import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/features/product/product.dart';
import 'package:talker_shop_app_example/features/products/view/products_screen.dart';
import 'package:talker_shop_app_example/ui/ui.dart';
import 'package:talker_shop_app_example/utils/utils.dart';

abstract class Routes {
  static const productsList = '/products-list';
  static const product = '/product';
  static const talker = '/talker';
}

final appRoutes = <String, WidgetBuilder>{
  Routes.product: (context) => const ProductScreen(),
  Routes.productsList: (context) => const ProductsScreen(),
  Routes.talker: (context) => TalkerScreen(
        talker: DI<Talker>(),
        theme: talkerTheme,
        appBarTitle: "Logger",
      ),
};
