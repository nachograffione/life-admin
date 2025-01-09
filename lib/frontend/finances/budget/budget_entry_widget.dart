import 'package:flutter/material.dart';
import 'package:life_admin/backend/finances/dtos.dart';
import 'package:life_admin/frontend/finances/budget/budget_entry_type_widget.dart';
import 'package:life_admin/frontend/shared/metadata_description.dart';
import 'package:life_admin/frontend/shared/metadata_name.dart';
import 'package:life_admin/frontend/shared/price_widget.dart';

class BudgetEntryWidget extends StatelessWidget {
  final BudgetEntryDto data;
  const BudgetEntryWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 50, child: BudgetEntryTypeWidget(data: data.type)),
          SizedBox(width: 250, child: MetadataName(data.metadata.name)),
          SizedBox(width: 200, child: PriceWidget(price: data.price)),
          const SizedBox(width: 100),
          MetadataDescription(data.metadata.description),
        ],
      ),
    );
  }
}
