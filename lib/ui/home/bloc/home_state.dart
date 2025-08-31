part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<ProductModel> latestProducts;
  final List<ProductModel> popularProducts;
  final List<BannerModel> banners;

  const HomeSuccess({
    required this.latestProducts,
    required this.popularProducts,
    required this.banners,
  });
}

final class HomeError extends HomeState {
  final AppException exception;

  const HomeError({required this.exception});

  @override
  List<Object> get props => [exception];
}
