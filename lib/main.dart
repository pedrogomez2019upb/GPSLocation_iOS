import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps URL',
        debugShowCheckedModeBanner: false,
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatelessWidget {
  Future<void> _openMaps() async {
    final location = Location();
    try {
      final currentLocation = await location.getLocation();
      final latitude = currentLocation.latitude;
      final longitude = currentLocation.longitude;
      final url =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps URL'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _openMaps,
          child: Text('Open Google Maps URL'),
        ),
      ),
    );
  }
}
