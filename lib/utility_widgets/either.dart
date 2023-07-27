import 'package:flutter/material.dart';

class Either extends StatelessWidget {
  final Widget first;
  final Widget second;

  const Either({super.key, required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget result = width < 600 ? first : second;
    return result;
  }
}
