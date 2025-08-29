import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../models/user.dart';
import '../models/match.dart';
import '../models/park.dart';
import '../services/location_service.dart';
import '../services/mock_data_service.dart';

class AppStateProvider extends ChangeNotifier {
  User? _currentUser;
  Position? _currentLocation;
  Match? _activeMatch;
  List<Park> _parks = [];
  List<Match> _matches = [];
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  Position? get currentLocation => _currentLocation;
  Match? get activeMatch => _activeMatch;
  List<Park> get parks => _parks;
  List<Match> get matches => _matches;
  bool get isLoading => _isLoading;

  AppStateProvider() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    _setLoading(true);
    
    // Load mock data
    _parks = MockDataService.getMockParks();
    _matches = MockDataService.getMockMatches();
    
    // Get current location
    await _getCurrentLocation();
    
    // Sort parks by distance if location is available
    if (_currentLocation != null) {
      _parks = LocationService.sortParksByDistance(
        _parks,
        _currentLocation!.latitude,
        _currentLocation!.longitude,
      );
      
      // Add distance to matches
      for (final match in _matches) {
        match.distanceFromUser = LocationService.calculateDistance(
          _currentLocation!.latitude,
          _currentLocation!.longitude,
          match.parkLatitude,
          match.parkLongitude,
        );
      }
      _matches.sort((a, b) => (a.distanceFromUser ?? 0).compareTo(b.distanceFromUser ?? 0));
    }
    
    _setLoading(false);
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentLocation = await LocationService.getCurrentLocation();
      notifyListeners();
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void setActiveMatch(Match? match) {
    _activeMatch = match;
    notifyListeners();
  }

  void signUpForMatch(String matchId) {
    final matchIndex = _matches.indexWhere((match) => match.id == matchId);
    if (matchIndex != -1) {
      final match = _matches[matchIndex];
      final updatedMatch = match.copyWith(
        signedUpPlayers: match.signedUpPlayers + 1,
        signedUpUserIds: [...match.signedUpUserIds, _currentUser?.id ?? ''],
      );
      _matches[matchIndex] = updatedMatch;
      
      // Set as active match
      _activeMatch = updatedMatch;
      notifyListeners();
    }
  }

  void leaveMatch() {
    if (_activeMatch != null) {
      final matchIndex = _matches.indexWhere((match) => match.id == _activeMatch!.id);
      if (matchIndex != -1) {
        final match = _matches[matchIndex];
        final updatedMatch = match.copyWith(
          signedUpPlayers: match.signedUpPlayers - 1,
          signedUpUserIds: match.signedUpUserIds.where((id) => id != _currentUser?.id).toList(),
        );
        _matches[matchIndex] = updatedMatch;
      }
      _activeMatch = null;
      notifyListeners();
    }
  }

  List<Park> searchParks(String query) {
    return MockDataService.searchParks(query);
  }
}
