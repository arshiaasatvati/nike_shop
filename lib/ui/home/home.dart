import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop/common/exceptions.dart';
import 'package:nike_shop/common/utils.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/repo/banner_repository.dart';
import 'package:nike_shop/data/repo/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop/theme.dart';
import 'package:nike_shop/ui/home/bloc/home_bloc.dart';
import 'package:nike_shop/ui/widgets/network_image.dart';
import 'package:nike_shop/ui/widgets/slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) {
        final homeBloc = HomeBloc(
          productRepository: productRepository,
          bannerRepository: bannerRepository,
        );
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                  physics: defaultScrollPhysics,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Container(
                          height: 56,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/nike_logo.png',
                            height: 24,
                          ),
                        );

                      case 2:
                        return BannerSlider(banners: state.banners);

                      case 3:
                        return _HorizontalProductsList(
                          title: 'جدید ترین',
                          onTap: () {},
                          products: state.latestProducts,
                        );

                      case 4:
                        return _HorizontalProductsList(
                          title: 'پربازدید ترین',
                          onTap: () {},
                          products: state.popularProducts,
                        );
                      default:
                        return Container();
                    }
                  },
                );
              } else if (state is HomeLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                );
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.exception.message),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                        },
                        child: Text(
                          'تلاش دوباره',
                          style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                throw AppException(message: 'invalid state');
              }
            },
          ),
        ),
      ),
    );
  }
}

class _HorizontalProductsList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductModel> products;
  const _HorizontalProductsList({
    required this.title,
    required this.onTap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 8, 12, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.apply(
                  color: LightThemeColors.secondaryTextColor,
                ),
              ),
              TextButton(
                onPressed: onTap,
                child: Text(
                  'مشاهده همه',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: LightThemeColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
            physics: defaultScrollPhysics,
            padding: EdgeInsets.only(left: 8, right: 8),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,

            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SizedBox(
                  width: 176,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 176,
                            height: 189,
                            child: ImageLoaderService(
                              imageUrl: product.imageUrl,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(CupertinoIcons.heart, size: 20),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          product.previousPrice.withPriceLable,
                          style: Theme.of(context).textTheme.labelMedium!
                              .copyWith(decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 4,
                        ),
                        child: Text(product.price.withPriceLable),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
