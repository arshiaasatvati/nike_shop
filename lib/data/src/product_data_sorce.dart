import 'package:dio/dio.dart';
import 'package:nike_shop/common/dio_response_validator.dart';
import 'package:nike_shop/data/model/product.dart';

abstract class IProductDataSource {
  Future<List<ProductModel>> getAll(int sort);
  Future<List<ProductModel>> search(String searchTerm);
}

class ProductRemoteDataSource
    with DioResponseValidator
    implements IProductDataSource {
  final Dio dioClient;

  ProductRemoteDataSource({required this.dioClient});
  @override
  Future<List<ProductModel>> getAll(int sort) async {
    final Response response = await dioClient.get('product/list?sort=$sort');
    validateResponse(response);
    final List<ProductModel> products = [];
    for (var element in (response.data as List)) {
      products.add(ProductModel.fromJson(element));
    }
    return products;
  }

  @override
  Future<List<ProductModel>> search(String searchTerm) async {
    final Response response = await dioClient.get(
      'product/search?q=$searchTerm',
    );
    validateResponse(response);
    final List<ProductModel> products = [];
    for (var element in (response.data as List)) {
      products.add(ProductModel.fromJson(element));
    }
    return products;
  }
}
