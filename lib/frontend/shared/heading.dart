import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  static const styles = {
    1: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    2: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    3: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  };

  static const padding = {
    1: EdgeInsets.only(bottom: 16),
    2: EdgeInsets.symmetric(vertical: 8),
    3: EdgeInsets.symmetric(vertical: 4),
  };

  final String data;
  final int level;

  Heading({super.key, required this.data, required this.level}) {
    assert(level >= 1 && level <= 3);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding[level]!,
      child: Text(
        data,
        style: styles[level],
      ),
    );
  }
}
