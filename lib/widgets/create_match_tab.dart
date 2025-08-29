import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../models/park.dart';
import '../widgets/park_selection_step.dart';
import '../widgets/time_selection_step.dart';
import '../widgets/player_count_step.dart';

class CreateMatchTab extends StatefulWidget {
  const CreateMatchTab({super.key});

  @override
  State<CreateMatchTab> createState() => _CreateMatchTabState();
}

class _CreateMatchTabState extends State<CreateMatchTab> {
  int _currentStep = 0;
  Park? _selectedPark;
  DateTime? _selectedDateTime;
  int _selectedPlayerCount = 6;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, appState, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: (_currentStep + 1) / 3,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
              ),
              
              const SizedBox(height: 24),
              
              // Step title
              Text(
                _getStepTitle(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 8),
              
              // Step description
              Text(
                _getStepDescription(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Step content
              Expanded(
                child: _buildStepContent(appState),
              ),
              
              // Navigation buttons
              Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _currentStep--;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: const BorderSide(color: Color(0xFF4CAF50)),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  if (_currentStep > 0) const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _canProceed() ? () {
                        if (_currentStep < 2) {
                          setState(() {
                            _currentStep++;
                          });
                        } else {
                          _createMatch(appState);
                        }
                      } : null,
                      child: Text(
                        _currentStep < 2 ? 'Next' : 'Create Match',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepContent(AppStateProvider appState) {
    switch (_currentStep) {
      case 0:
        return ParkSelectionStep(
          parks: appState.parks.take(5).toList(),
          selectedPark: _selectedPark,
          onParkSelected: (park) {
            setState(() {
              _selectedPark = park;
            });
          },
        );
      case 1:
        return TimeSelectionStep(
          selectedDateTime: _selectedDateTime,
          onDateTimeSelected: (dateTime) {
            setState(() {
              _selectedDateTime = dateTime;
            });
          },
        );
      case 2:
        return PlayerCountStep(
          selectedCount: _selectedPlayerCount,
          onCountChanged: (count) {
            setState(() {
              _selectedPlayerCount = count;
            });
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Where will the game take place?';
      case 1:
        return 'What time will the game take place?';
      case 2:
        return 'How many players do you want playing?';
      default:
        return '';
    }
  }

  String _getStepDescription() {
    switch (_currentStep) {
      case 0:
        return 'Select a field from the list below or search for a specific location.';
      case 1:
        return 'Choose the date and time for your pickup game.';
      case 2:
        return 'Select the total number of players needed for the game.';
      default:
        return '';
    }
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _selectedPark != null;
      case 1:
        return _selectedDateTime != null;
      case 2:
        return _selectedPlayerCount > 0;
      default:
        return false;
    }
  }

  void _createMatch(AppStateProvider appState) {
    if (_selectedPark != null && _selectedDateTime != null) {
      // In a real app, this would create the match in the backend
      // For now, we'll just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Match created successfully!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      
      // Reset form
      setState(() {
        _currentStep = 0;
        _selectedPark = null;
        _selectedDateTime = null;
        _selectedPlayerCount = 6;
      });
    }
  }
}
