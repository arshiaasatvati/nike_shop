import 'package:nike_shop/common/dio_client.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/src/product_data_sorce.dart';

final productRepository = ProductRepository(
  productDataSource: ProductRemoteDataSource(dioClient: dioClient),
);

abstract class IProductRepository {
  Future<List<ProductModel>> getAll(int sort);
  Future<List<ProductModel>> search(String searchTerm);
}

class ProductRepository implements IProductRepository {
  final IProductDataSource productDataSource;

  ProductRepository({required this.productDataSource});
  @override
  Future<List<ProductModel>> getAll(int sort) => productDataSource.getAll(sort);

  @override
  Future<List<ProductModel>> search(String searchTerm) =>
      productDataSource.search(searchTerm);
}
