import 'package:talker_shop_app_example/repositories/products/products.dart';

const _mockProducts = [
  Product(
    id: '1',
    name: 'Nike Air Plus',
    type: 'Running shoes',
    price: 299,
    image: 'assets/air_max_plus.png',
  ),
  Product(
    id: '2',
    name: 'Nike Air White',
    type: 'Running shoes',
    price: 299,
    image: 'assets/air_max_plus_white.png',
  ),
  Product(
    id: '3',
    name: 'Dark shoes',
    type: 'Walking shoes',
    price: 449,
    image: 'assets/black.png',
  ),
  Product(
    id: '4',
    name: 'Blue shoes',
    type: 'Running shoes',
    price: 300,
    image: 'assets/blue_shoe.png',
  ),
  Product(
    id: '5',
    name: 'Red shoes',
    type: 'Walking shoes',
    price: 300,
    image: 'assets/red_shoe.png',
  ),
];

/// [_requestsCount > 1] - special mock logic
/// to check how logs working in differend ways of logic
class ProductsRepository implements AbstractProductsRepository {
  var _requestsCount = 0;

  @override
  Future<List<Product>> getProductsList() async {
    _requestsCount += 1;

    if (_requestsCount > 1) {
      return _mockProducts;
    }
    throw Exception('Products not loaded');
  }

  @override
  Future<Product> getProduct(String id) async {
    return _mockProducts.firstWhere((e) => e.id == id);
  }
}
