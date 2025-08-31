import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_shop/common/exceptions.dart';
import 'package:nike_shop/data/model/banner.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/repo/banner_repository.dart';
import 'package:nike_shop/data/repo/product_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IProductRepository productRepository;
  final IBannerRepository bannerRepository;
  HomeBloc({required this.productRepository, required this.bannerRepository})
    : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final latestProducts = await productRepository.getAll(
            ProductSort.latest,
          );
          final popularProducts = await productRepository.getAll(
            ProductSort.popular,
          );
          final banners = await bannerRepository.getAll();

          emit(
            HomeSuccess(
              latestProducts: latestProducts,
              popularProducts: popularProducts,
              banners: banners,
            ),
          );
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
