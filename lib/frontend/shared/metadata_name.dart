import 'package:flutter/material.dart';

class MetadataName extends StatelessWidget {
  final String value;
  const MetadataName(this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(value);
  }
}
