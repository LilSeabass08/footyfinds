import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../services/location_service.dart';
import '../widgets/match_list_item.dart';

class PickupsTab extends StatelessWidget {
  const PickupsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appState, child) {
        if (appState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (appState.matches.isEmpty) {
          return const Center(
            child: Text(
              'No pickup games available',
              style: TextStyle(fontSize: 16),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: appState.matches.length,
          itemBuilder: (context, index) {
            final match = appState.matches[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MatchListItem(match: match),
            );
          },
        );
      },
    );
  }
}
