import 'package:flutter/material.dart';
import '../models/park.dart';
import '../services/location_service.dart';

class ParkListItem extends StatelessWidget {
  final Park park;

  const ParkListItem({
    super.key,
    required this.park,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Park image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                park.imageUrl ?? 'https://via.placeholder.com/80x80/CCCCCC/666666?text=Field',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.sports_soccer,
                      color: Colors.grey,
                      size: 32,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            
            // Park details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    park.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    park.address,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            
            // Distance
            if (park.distanceFromUser != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  LocationService.formatDistance(park.distanceFromUser!),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
