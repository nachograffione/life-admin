import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_admin/backend/finances/dtos.dart';
import 'package:life_admin/frontend/shared/metadata_description.dart';
import 'package:life_admin/frontend/shared/metadata_name.dart';
import 'package:life_admin/frontend/shared/price_widget.dart';

class CatalogEntryWidget extends StatelessWidget {
  final CatalogEntryDto data;
  const CatalogEntryWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 250, child: MetadataName(data.metadata.name)),
          SizedBox(width: 200, child: PriceWidget(price: data.price)),
          const SizedBox(width: 100),
          SizedBox(width: 100, child: MetadataDescription(_buildUpdating())),
          MetadataDescription(data.metadata.description),
        ],
      ),
    );
  }

  String _buildUpdating() {
    final date = DateFormat('dd-MM-yy').format(data.lastPriceUpdate);
    final adjustment = data.adjustForInflation ? 'Adj.' : 'Fixed';
    return '$date ($adjustment)';
  }
}
