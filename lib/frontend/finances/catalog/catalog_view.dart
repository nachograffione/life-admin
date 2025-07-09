import 'package:flutter/material.dart';
import 'package:life_admin/frontend/finances/catalog/catalog_table.dart';
import 'package:life_admin/frontend/shared/custom_scrollable.dart';
import 'package:life_admin/frontend/shared/heading.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollable(
      scrollDirection: Axis.vertical,
      children: [
        Heading(data: 'Catalog', level: 1),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: CatalogTable(),
        ),
      ],
    );
  }
}
