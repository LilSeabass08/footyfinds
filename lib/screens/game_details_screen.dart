import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match.dart';
import '../providers/app_state_provider.dart';
import '../services/map_service.dart';

class GameDetailsScreen extends StatelessWidget {
  final Match match;

  const GameDetailsScreen({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Details'),
        actions: [
          Consumer<AppStateProvider>(
            builder: (context, appState, child) {
              final isSignedUp = appState.activeMatch?.id == match.id;
              return IconButton(
                onPressed: isSignedUp ? () {
                  appState.leaveMatch();
                  Navigator.pop(context);
                } : null,
                icon: const Icon(Icons.exit_to_app),
                tooltip: 'Leave Game',
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Game header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.sports_soccer,
                          color: Color(0xFF4CAF50),
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                match.parkName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${match.signedUpPlayers}/${match.totalPlayers} players',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Game time
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Color(0xFF4CAF50),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Game Time',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDateTime(match.dateTime),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Location details
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF4CAF50),
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Location',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () async {
                        final success = await MapService.openDirections(
                          match.parkLatitude,
                          match.parkLongitude,
                          match.parkAddress,
                        );
                        
                        if (!success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Could not open map app'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF4CAF50)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                match.parkAddress,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4CAF50),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.directions,
                              color: Color(0xFF4CAF50),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap to open directions in your map app',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Game status
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Game Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          match.isFull ? Icons.check_circle : Icons.pending,
                          color: match.isFull ? Colors.green : Colors.orange,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            match.isFull
                                ? 'Game is full!'
                                : '${match.playersNeeded} more players needed',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: match.isFull ? Colors.green : Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final matchDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    
    String dateText;
    if (matchDate == today) {
      dateText = 'Today';
    } else if (matchDate == today.add(const Duration(days: 1))) {
      dateText = 'Tomorrow';
    } else {
      dateText = '${dateTime.month}/${dateTime.day}/${dateTime.year}';
    }
    
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    
    return '$dateText at $hour:$minute $period';
  }
}
