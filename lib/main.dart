import 'package:flutter/material.dart';
import 'package:nike_shop/theme.dart';
import 'package:nike_shop/ui/home/home.dart';

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
        child: const HomeScreen(),
      ),
    );
  }
}
