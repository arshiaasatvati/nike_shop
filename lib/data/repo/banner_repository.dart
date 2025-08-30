import 'package:nike_shop/common/dio_client.dart';
import 'package:nike_shop/data/model/banner.dart';
import 'package:nike_shop/data/src/banner_data_source.dart';

final bannerRepository = BannerRepository(
  bannerRemoteDataSource: BannerRemoteDataSource(dioClient: dioClient),
);

abstract class IBannerRepository {
  Future<List<BannerModel>> getAll();
}

class BannerRepository implements IBannerRepository {
  final BannerRemoteDataSource bannerRemoteDataSource;

  BannerRepository({required this.bannerRemoteDataSource});
  @override
  Future<List<BannerModel>> getAll() => bannerRemoteDataSource.getAll();
}
