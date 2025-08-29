import 'package:dio/dio.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/src/product_data_sorce.dart';

final dioClient = Dio(BaseOptions(baseUrl: 'https://fapi.7learn.com/api/v1/'));

final productRepository = ProductRepository(
  productDataSource: ProductRemoteDataSource(dioClient: dioClient),
);

abstract class IProductRepository {
  Future<List<Product>> getAll(int sort);
  Future<List<Product>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource productDataSource;

  ProductRepository({required this.productDataSource});
  @override
  Future<List<Product>> getAll(int sort) => productDataSource.getAll(sort);

  @override
  Future<List<Product>> search(String searchTerm) =>
      productDataSource.search(searchTerm);
}
