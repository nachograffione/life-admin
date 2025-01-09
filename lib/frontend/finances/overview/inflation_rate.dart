import 'package:flutter/material.dart';
import 'package:life_admin/backend/finances/inflation_rate_interval.dart';
import 'package:life_admin/backend/shared/datetime_manager.dart';
import 'package:life_admin/frontend/app_state/app_state.dart';
import 'package:provider/provider.dart';

class InflationRate extends StatelessWidget {
  const InflationRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      if (appState.financesManager == null) {
        return const Center(child: CircularProgressIndicator());
      }
      final mtdInflationRatePercentage = appState.financesManager!
              .getInflationRate(
                  DefaultDateTimeManager().now(), InflationRateInterval.mtd) *
          100;
      final ytdInflationRatePercentage = appState.financesManager!
              .getInflationRate(
                  DefaultDateTimeManager().now(), InflationRateInterval.ytd) *
          100;
      final interAnnualInflationRatePercentage = appState.financesManager!
              .getInflationRate(DefaultDateTimeManager().now(),
                  InflationRateInterval.interAnnual) *
          100;

      return Column(
        children: [
          const Text('Inflation rate'),
          Text('MTD: ${mtdInflationRatePercentage.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 16)),
          Text('YTD: ${ytdInflationRatePercentage.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 16)),
          Text(
              'Interannual: ${interAnnualInflationRatePercentage.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 16)),
        ],
      );
    });
  }
}
