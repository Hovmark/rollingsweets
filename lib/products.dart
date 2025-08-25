import 'package:flutter/material.dart';
import 'package:rollingsweets/main.dart';

final products = [
  ProductWidget(
      header: 'Cookie-Glass',
      description:
          'Två kakor med en kula glass emellan. Finns i glasssmakerna smakerna vanilj, pistage och rabarber',
      customIcon: Image.asset(
        'assets/icons/cookieglass.png',
        color: Colors.white,
        height: 80,
      ),
      icon: Icons.icecream_outlined),
  const ProductWidget(
      header: 'Cookies',
      description:
          'Härliga, hemmabakade kakor. Krispiga på ytan med en mjuk mitten, finns i  smakerna Chocolate chip, White Chocolate chip, Farmors kola.',
      icon: Icons.cookie_outlined),
  ProductWidget(
      header: 'Fudge',
      description:
          'Mjuk fudge med en krämig konsistens. Bakas i smakerna choklad, vit choklad, salt kola och lakrits.',
      customIcon: Image.asset(
        'assets/icons/fudge.png',
        color: Colors.white,
        height: 80,
      ),
      icon: Icons.crop_square),
  ProductWidget(
      header: 'Brända Mandlar',
      description:
          'Klassiska brända mandlar med en söt och krispig yta. Perfekta som snacks eller som present.',
      customIcon: Image.asset(
        'assets/icons/almonds.png',
        color: Colors.white,
        height: 80,
      ),
      icon: Icons.gesture_outlined),
];
