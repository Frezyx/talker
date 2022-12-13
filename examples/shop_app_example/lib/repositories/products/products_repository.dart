import 'package:dio/dio.dart';
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
  ProductsRepository({required Dio dio}) : _dio = dio;
  var _requestsCount = 0;

  final Dio _dio;

  @override
  Future<List<Product>> getProductsList() async {
    _requestsCount += 1;
    if (_requestsCount % 2 != 0) {
      await _dio.get('https://jsonplaceholder.typicode.com/users/1');
      return _mockProducts;
    }

    /// Incorrect http request path
    await _dio.get('https://jsonplaceholder.typicode.com/usetyrtyergvf/1');
    return _mockProducts;
  }

  @override
  Future<Product> getProduct(String id) async {
    await _dio.get('https://jsonplaceholder.typicode.com/users/1');
    return _mockProducts.firstWhere((e) => e.id == id);
  }

  @override
  Future<void> addToFavorites(String id) async {
    _requestsCount += 1;
    if (_requestsCount % 2 != 0) {
      await _dio.put('https://jsonplaceholder.typicode.com/users/1');
      return;
    }

    /// Incorrect request
    await _dio.put('https://jsonplaceholder.typicode.comuseahstdfr/1');
  }

  @override
  Future<void> addToCart(String id) async {
    _requestsCount += 1;
    if (_requestsCount % 2 != 0) {
      await _dio.post('https://jsonplaceholder.typicode.com/users/1');
      return;
    }

    /// Incorrect request
    await _dio.post('https://jsonplaceholder.typicode.comusyeyrutwyetf/1');
  }
}
