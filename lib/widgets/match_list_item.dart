import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match.dart';
import '../providers/app_state_provider.dart';
import '../services/location_service.dart';

class MatchListItem extends StatelessWidget {
  final Match match;

  const MatchListItem({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appState, child) {
        final isSignedUp = appState.activeMatch?.id == match.id;
        
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with park name and distance
                Row(
                  children: [
                    const Icon(
                      Icons.sports_soccer,
                      color: Color(0xFF4CAF50),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        match.parkName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (match.distanceFromUser != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          LocationService.formatDistance(match.distanceFromUser!),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Match details
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDateTime(match.dateTime),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.people,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${match.signedUpPlayers}/${match.totalPlayers} players',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Sign up button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isSignedUp ? null : () {
                      appState.signUpForMatch(match.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Signed up for game at ${match.parkName}'),
                          backgroundColor: const Color(0xFF4CAF50),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSignedUp ? Colors.grey : const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      isSignedUp ? 'Signed Up' : 'Sign Up',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
      dateText = '${dateTime.month}/${dateTime.day}';
    }
    
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    
    return '$dateText at $hour:$minute $period';
  }
}
