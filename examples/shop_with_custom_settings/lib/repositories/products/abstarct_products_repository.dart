import 'package:talker_shop_app_example/repositories/products/products.dart';

abstract class AbstractProductsRepository {
  Future<List<Product>> getProductsList();
  Future<Product> getProduct(String id);
  Future<void> addToFavorites(String id);
  Future<void> addToCart(String id);
}
