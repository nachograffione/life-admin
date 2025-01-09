import 'package:flutter/material.dart';

class CustomScrollable extends StatelessWidget {
  final Axis scrollDirection;
  final List<Widget> children;

  const CustomScrollable(
      {super.key, required this.scrollDirection, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: ListView(
        scrollDirection: scrollDirection,
        children: children
            .map((child) => Padding(
                  // To avoid collision with scrollbar
                  padding: scrollDirection == Axis.horizontal
                      ? const EdgeInsets.only(right: 4.0)
                      : const EdgeInsets.only(bottom: 4.0),
                  child: child,
                ))
            .toList(),
      ),
    );
  }
}
