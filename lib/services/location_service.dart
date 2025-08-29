import 'package:geolocator/geolocator.dart';
import '../models/park.dart';

class LocationService {
  static Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  static double calculateDistance(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  static List<Park> sortParksByDistance(
    List<Park> parks,
    double userLatitude,
    double userLongitude,
  ) {
    for (final park in parks) {
      park.distanceFromUser = calculateDistance(
        userLatitude,
        userLongitude,
        park.latitude,
        park.longitude,
      );
    }

    parks.sort((a, b) => (a.distanceFromUser ?? 0).compareTo(b.distanceFromUser ?? 0));
    return parks;
  }

  static String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.round()}m';
    } else {
      final distanceInKm = distanceInMeters / 1000;
      return '${distanceInKm.toStringAsFixed(1)}km';
    }
  }
}
