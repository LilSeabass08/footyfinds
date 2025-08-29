import '../models/park.dart';
import '../models/match.dart';

class MockDataService {
  static List<Park> getMockParks() {
    return [
      Park(
        id: '1',
        name: 'Central Park Soccer Field',
        address: '123 Central Park Ave, New York, NY 10024',
        latitude: 40.7829,
        longitude: -73.9654,
        imageUrl: 'https://via.placeholder.com/300x200/4CAF50/FFFFFF?text=Central+Park',
      ),
      Park(
        id: '2',
        name: 'Riverside Park',
        address: '456 Riverside Dr, New York, NY 10025',
        latitude: 40.7855,
        longitude: -73.9814,
        imageUrl: 'https://via.placeholder.com/300x200/2196F3/FFFFFF?text=Riverside+Park',
      ),
      Park(
        id: '3',
        name: 'Prospect Park',
        address: '789 Prospect Park West, Brooklyn, NY 11215',
        latitude: 40.6602,
        longitude: -73.9690,
        imageUrl: 'https://via.placeholder.com/300x200/FF9800/FFFFFF?text=Prospect+Park',
      ),
      Park(
        id: '4',
        name: 'Flushing Meadows Park',
        address: '321 Flushing Meadows Blvd, Queens, NY 11368',
        latitude: 40.7505,
        longitude: -73.8456,
        imageUrl: 'https://via.placeholder.com/300x200/9C27B0/FFFFFF?text=Flushing+Meadows',
      ),
      Park(
        id: '5',
        name: 'Van Cortlandt Park',
        address: '654 Van Cortlandt Park S, Bronx, NY 10471',
        latitude: 40.8987,
        longitude: -73.8868,
        imageUrl: 'https://via.placeholder.com/300x200/F44336/FFFFFF?text=Van+Cortlandt',
      ),
    ];
  }

  static List<Match> getMockMatches() {
    return [
      Match(
        id: '1',
        parkId: '1',
        parkName: 'Central Park Soccer Field',
        parkAddress: '123 Central Park Ave, New York, NY 10024',
        parkLatitude: 40.7829,
        parkLongitude: -73.9654,
        dateTime: DateTime.now().add(const Duration(hours: 2)),
        totalPlayers: 10,
        signedUpPlayers: 7,
        createdBy: 'user1',
        signedUpUserIds: ['user1', 'user2', 'user3', 'user4', 'user5', 'user6', 'user7'],
      ),
      Match(
        id: '2',
        parkId: '2',
        parkName: 'Riverside Park',
        parkAddress: '456 Riverside Dr, New York, NY 10025',
        parkLatitude: 40.7855,
        parkLongitude: -73.9814,
        dateTime: DateTime.now().add(const Duration(hours: 4)),
        totalPlayers: 8,
        signedUpPlayers: 5,
        createdBy: 'user2',
        signedUpUserIds: ['user2', 'user3', 'user4', 'user5', 'user6'],
      ),
      Match(
        id: '3',
        parkId: '3',
        parkName: 'Prospect Park',
        parkAddress: '789 Prospect Park West, Brooklyn, NY 11215',
        parkLatitude: 40.6602,
        parkLongitude: -73.9690,
        dateTime: DateTime.now().add(const Duration(days: 1)),
        totalPlayers: 12,
        signedUpPlayers: 9,
        createdBy: 'user3',
        signedUpUserIds: ['user3', 'user4', 'user5', 'user6', 'user7', 'user8', 'user9', 'user10', 'user11'],
      ),
    ];
  }

  static List<Park> searchParks(String query) {
    final allParks = getMockParks();
    return allParks
        .where((park) =>
            park.name.toLowerCase().contains(query.toLowerCase()) ||
            park.address.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
