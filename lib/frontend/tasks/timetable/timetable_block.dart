import 'package:flutter/material.dart';

class TimetableBlock extends StatelessWidget {
  const TimetableBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.amber.shade200.withAlpha(98);
    final borderColor = Colors.black.withAlpha(98);

    return Container(
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 1, color: borderColor),
      ),
    );
  }
}
