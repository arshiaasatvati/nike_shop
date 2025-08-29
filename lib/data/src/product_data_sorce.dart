import 'package:dio/dio.dart';
import 'package:nike_shop/common/exceptions.dart';
import 'package:nike_shop/data/model/product.dart';

abstract class IProductDataSource {
  Future<List<Product>> getAll(int sort);
  Future<List<Product>> search(String searchTerm);
}

class ProductRemoteDataSource implements IProductDataSource {
  final Dio dioClient;

  ProductRemoteDataSource({required this.dioClient});
  @override
  Future<List<Product>> getAll(int sort) async {
    final Response response = await dioClient.get('product/list?sort=$sort');
    validateResponse(response);
    final List<Product> products = [];
    (response.data as List).forEach((element) {
      products.add(Product.fromJson(element));
    });
    return products;
  }

  @override
  Future<List<Product>> search(String searchTerm) async {
    final Response response = await dioClient.get(
      'product/search?q=$searchTerm',
    );
    validateResponse(response);
    final List<Product> products = [];
    for (var element in (response.data as List)) {
      products.add(Product.fromJson(element));
    }
    return products;
  }

  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
