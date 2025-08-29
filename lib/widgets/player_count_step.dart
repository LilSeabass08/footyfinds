import 'package:flutter/material.dart';

class PlayerCountStep extends StatelessWidget {
  final int selectedCount;
  final Function(int) onCountChanged;

  const PlayerCountStep({
    super.key,
    required this.selectedCount,
    required this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Player count selection
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.people, color: Color(0xFF4CAF50)),
                    const SizedBox(width: 8),
                    const Text(
                      'Number of Players',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: selectedCount,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: 'Select number of players',
                  ),
                  items: List.generate(11, (index) {
                    final count = index + 1;
                    return DropdownMenuItem<int>(
                      value: count,
                      child: Text('$count players'),
                    );
                  }),
                  onChanged: (value) {
                    if (value != null) {
                      onCountChanged(value);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Selected count display
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF4CAF50)),
          ),
          child: Column(
            children: [
              const Text(
                'Selected Player Count',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '$selectedCount players',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Info card
        Card(
          color: Colors.blue[50],
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue[700],
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'This will be the total number of players needed for the game. Other users can sign up to join your pickup game.',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
