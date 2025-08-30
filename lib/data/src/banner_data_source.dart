import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nike_shop/common/dio_response_validator.dart';
import 'package:nike_shop/data/model/banner.dart';

abstract class IBannerDataSource {
  Future<List<BannerModel>> getAll();
}

class BannerRemoteDataSource
    with DioResponseValidator
    implements IBannerDataSource {
  final Dio dioClient;

  BannerRemoteDataSource({required this.dioClient});
  @override
  Future<List<BannerModel>> getAll() async {
    final Response response = await dioClient.get('banner/slider');
    validateResponse(response);

    final List<BannerModel> banners = await compute(
      parseBanners,
      response.data,
    );

    return banners;
  }
}

List<BannerModel> parseBanners(dynamic data) {
  final List<BannerModel> banners = [];
  for (var jsonObject in (data as List)) {
    banners.add(BannerModel.fromJson(jsonObject));
  }
  return banners;
}
