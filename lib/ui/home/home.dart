import 'package:flutter/material.dart';
import 'package:nike_shop/common/exceptions.dart';
import 'package:nike_shop/common/utils.dart';
import 'package:nike_shop/data/model/banner.dart';
import 'package:nike_shop/data/repo/banner_repository.dart';
import 'package:nike_shop/data/repo/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
