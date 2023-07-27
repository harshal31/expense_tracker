import 'package:flutter/material.dart';


final kColorScheme = ColorScheme.fromSwatch(
  brightness: Brightness.light,
  primarySwatch: getMaterialColor(
    const Color.fromARGB(255, 96, 59, 101),
  ),
);

final kDarkColorScheme = ColorScheme.fromSwatch(
  brightness: Brightness.dark,
  primarySwatch: getMaterialColor(
    const Color.fromARGB(255, 5, 99, 125),
  ),
);

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;
  final int alpha = color.alpha;

  final Map<int, Color> shades = {
    50: Color.fromARGB(alpha, red, green, blue),
    100: Color.fromARGB(alpha, red, green, blue),
    200: Color.fromARGB(alpha, red, green, blue),
    300: Color.fromARGB(alpha, red, green, blue),
    400: Color.fromARGB(alpha, red, green, blue),
    500: Color.fromARGB(alpha, red, green, blue),
    600: Color.fromARGB(alpha, red, green, blue),
    700: Color.fromARGB(alpha, red, green, blue),
    800: Color.fromARGB(alpha, red, green, blue),
    900: Color.fromARGB(alpha, red, green, blue),
  };

  return MaterialColor(color.value, shades);
}
