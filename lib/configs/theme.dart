import 'package:flutter/material.dart';

class app_theme {
  static MaterialColor primary_color = const MaterialColor(0xff01efc5, {
    50: const Color(0xff01efc5),
    100: const Color(0xff54fde1),
    200: const Color(0xff09c19b),
    300: const Color(0xff0d9980),
    400: const Color(0xff039077),
    500: const Color(0xff007660),
    600: const Color(0xff014c3c),
    700: const Color(0xff024d40),
    800: const Color(0xff024c3f),
    900: const Color(0xff012a23)
  });

  // static Color primary_color = Color(0xff01efc5);
  static TextStyle ts_name =
      TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle ts_price =
      TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold);
  static TextStyle ts_qyt =
      TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold);

  static TextStyle stock__info_tags = TextStyle(
    fontSize: 22,
    color: Colors.white60,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    decorationColor: primary_color.shade600,
    decorationThickness: 1,

    decorationStyle: TextDecorationStyle.dashed,
  );
}
