import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../services/location_service.dart';
import '../widgets/park_list_item.dart';

class FieldListingsTab extends StatelessWidget {
  const FieldListingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appState, child) {
        if (appState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (appState.parks.isEmpty) {
          return const Center(
            child: Text(
              'No fields found nearby',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        // Show only first 10 listings as per requirements
        final parksToShow = appState.parks.take(10).toList();

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: parksToShow.length,
          itemBuilder: (context, index) {
            final park = parksToShow[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ParkListItem(park: park),
            );
          },
        );
      },
    );
  }
}
