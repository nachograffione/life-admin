import 'package:flutter/material.dart';
import 'package:life_admin/backend/finances/dtos.dart';
import 'package:life_admin/frontend/utils.dart';

class PriceWidget extends StatelessWidget {
  late final TextStyle mainStyle;
  late final TextStyle secondaryStyle;

  final PriceDto price;

  PriceWidget({super.key, required this.price}) {
    mainStyle = const TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    secondaryStyle = TextStyle(
      color: dullDownColor(Colors.black, 0.3),
      fontSize: 12,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Text(
              '\$',
              style: mainStyle,
            ),
            Container(
              alignment: Alignment.centerRight,
              width: 70,
              child: Text(
                roundToResolution(price.value, 100).toStringAsFixed(0),
                style: mainStyle,
              ),
            ),
          ],
        ),
        const SizedBox(width: 40),
        Row(
          children: [
            Text(
              '\u00B1',
              style: secondaryStyle,
            ),
            Container(
              alignment: Alignment.centerRight,
              width: 50,
              child: Text(
                roundToResolution(price.absoluteError, 100).toStringAsFixed(0),
                style: secondaryStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
