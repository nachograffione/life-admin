import 'package:flutter/material.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:life_admin/frontend/finances/catalog/catalog_entry_widget.dart';
import 'package:provider/provider.dart';

class CatalogTable extends StatelessWidget {
  const CatalogTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.financesManager == null) {
        return const Center(child: CircularProgressIndicator());
      }

      final entries = appState.financesManager!.getCatalogEntries();

      return Column(
        children:
            entries.map((entry) => CatalogEntryWidget(data: entry)).toList(),
      );
    });
  }
}
