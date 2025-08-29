import 'package:flutter/material.dart';
import '../models/park.dart';
import '../services/location_service.dart';

class ParkSelectionStep extends StatefulWidget {
  final List<Park> parks;
  final Park? selectedPark;
  final Function(Park) onParkSelected;

  const ParkSelectionStep({
    super.key,
    required this.parks,
    required this.selectedPark,
    required this.onParkSelected,
  });

  @override
  State<ParkSelectionStep> createState() => _ParkSelectionStepState();
}

class _ParkSelectionStepState extends State<ParkSelectionStep> {
  final TextEditingController _searchController = TextEditingController();
  List<Park> _filteredParks = [];

  @override
  void initState() {
    super.initState();
    _filteredParks = widget.parks;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterParks(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredParks = widget.parks;
      } else {
        _filteredParks = widget.parks
            .where((park) =>
                park.name.toLowerCase().contains(query.toLowerCase()) ||
                park.address.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        TextField(
          controller: _searchController,
          onChanged: _filterParks,
          decoration: InputDecoration(
            hintText: 'Search for a park...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Parks list
        Expanded(
          child: ListView.builder(
            itemCount: _filteredParks.length,
            itemBuilder: (context, index) {
              final park = _filteredParks[index];
              final isSelected = widget.selectedPark?.id == park.id;
              
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                color: isSelected ? const Color(0xFF4CAF50).withOpacity(0.1) : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isSelected
                      ? const BorderSide(color: Color(0xFF4CAF50), width: 2)
                      : BorderSide.none,
                ),
                child: InkWell(
                  onTap: () => widget.onParkSelected(park),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Park image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            park.imageUrl ?? 'https://via.placeholder.com/60x60/CCCCCC/666666?text=Field',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.sports_soccer,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                              );
                            },
                          ),
                        ),
                        
                        const SizedBox(width: 12),
                        
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
                              if (park.distanceFromUser != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  LocationService.formatDistance(park.distanceFromUser!),
                                  style: const TextStyle(
                                    color: Color(0xFF4CAF50),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        
                        // Selection indicator
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: Color(0xFF4CAF50),
                            size: 24,
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
