import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class MapService {
  static Future<bool> openDirections(
    double latitude,
    double longitude,
    String address,
  ) async {
    final String url;
    
    if (Platform.isIOS) {
      // Apple Maps URL format
      url = 'https://maps.apple.com/?daddr=$latitude,$longitude&dirflg=d';
    } else {
      // Google Maps URL format for Android and web
      url = 'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    }

    final Uri uri = Uri.parse(url);
    
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
    
    return false;
  }

  static String generateStaticMapUrl(
    double latitude,
    double longitude,
    int width,
    int height,
    int zoom,
  ) {
    // This would typically use Google Maps Static API
    // For now, returning a placeholder URL
    return 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=$latitude,$longitude'
        '&zoom=$zoom'
        '&size=${width}x$height'
        '&markers=color:red%7C$latitude,$longitude'
        '&key=YOUR_API_KEY';
  }
}
