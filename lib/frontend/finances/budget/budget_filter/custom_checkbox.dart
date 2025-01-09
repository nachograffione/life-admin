import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final int indentLevel;
  final bool isChecked;
  final Function(bool?) onChanged;
  final Widget child;

  const CustomCheckbox({
    super.key,
    required this.indentLevel,
    required this.isChecked,
    required this.onChanged,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: indentLevel * 16),
          child: Checkbox(
            value: isChecked,
            onChanged: (value) {
              onChanged(value);
            },
            splashRadius: 16,
            visualDensity: VisualDensity.compact,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: child,
        ),
      ],
    );
  }
}
