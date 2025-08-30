import 'package:flutter/material.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/repo/banner_repository.dart';
import 'package:nike_shop/data/repo/product_repository.dart';
import 'package:nike_shop/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle defaultTextStyle = TextStyle(fontFamily: 'Shabnam');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Shabnam',
            fontWeight: FontWeight.bold,
            color: LightThemeColors.primaryTextColor,
          ),
          labelMedium: defaultTextStyle.apply(
            color: LightThemeColors.secondaryTextColor,
          ),
          headlineMedium: defaultTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),

          titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.light(
          primary: LightThemeColors.primaryColor,
          onPrimary: Colors.white,
          secondary: LightThemeColors.secondaryColor,
          onSecondary: Colors.white,
        ),
      ),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    productRepository
        .getAll(ProductSort.latest)
        .then((value) {
          debugPrint(value.first.title.toString());
        })
        .catchError((e) {
          debugPrint(e.toString());
        });

    bannerRepository
        .getAll()
        .then((value) {
          debugPrint(value.first.imageUrl.toString());
        })
        .catchError((e) {
          debugPrint(e.toString());
        });

    return Scaffold(body: Center(child: Text('test')));
  }
}
