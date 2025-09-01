import 'package:flutter/material.dart';
import 'package:nike_shop/common/utils.dart';
import 'package:nike_shop/data/model/banner.dart';
import 'package:nike_shop/data/test_banner_items.dart';
import 'package:nike_shop/theme.dart';
import 'package:nike_shop/ui/widgets/network_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatelessWidget {
  final PageController _controller = PageController();
  final List<BannerModel> banners;
  BannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
            physics: defaultScrollPhysics,
            controller: _controller,
            itemCount: bannerTestUrls.length,
            itemBuilder: (context, index) =>
                _Slide(imageUrl: bannerTestUrls[index]),
          ),
          Positioned(
            bottom: 8,
            right: 0,
            left: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: bannerTestUrls.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                  spacing: 4.0,
                  radius: 4.0,
                  dotWidth: 20.0,
                  dotHeight: 3,
                  paintStyle: PaintingStyle.fill,
                  dotColor: LightThemeColors.secondaryTextColor,
                  // ignore: deprecated_member_use
                  activeDotColor: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String imageUrl;
  const _Slide({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ImageLoaderService(
        imageUrl: imageUrl,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
