import 'package:flutter/widgets.dart';

const defaultScrollPhysics = BouncingScrollPhysics();

extension PriceLabel on int {
  String get withPriceLable => '$this تومان';
}
