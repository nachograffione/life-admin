import 'package:flutter/material.dart';
import 'package:life_admin/frontend/utils.dart';

class MetadataDescription extends StatelessWidget {
  final String value;
  const MetadataDescription(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(value,
        style: TextStyle(
          fontSize: 10,
          color: dullDownColor(Colors.black, 0.3),
        ));
  }
}
