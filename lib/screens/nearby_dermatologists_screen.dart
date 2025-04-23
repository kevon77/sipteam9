import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyDermatologistsScreen extends StatefulWidget {
  @override
  _NearbyDermatologistsScreenState createState() => _NearbyDermatologistsScreenState();
}

class _NearbyDermatologistsScreenState extends State<NearbyDermatologistsScreen> {
  List<dynamic> _places = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchNearbyDermatologists();
  }

  Future<void> _fetchNearbyDermatologists() async {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception('Location services are disabled.');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
          throw Exception('Location permissions are denied.');
        }
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      double lat = position.latitude;
      double lng = position.longitude;

      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&radius=5000&type=doctor&keyword=dermatologist&key=$apiKey',
      );

      final response = await http.get(url);
      final json = jsonDecode(response.body);

      setState(() {
        _places = json['results'];
        _loading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to fetch location or data.")),
      );
    }
  }

  Future<void> _openGoogleMaps(String address) async {
    final Uri googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}',
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open Google Maps.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Nearby Dermatologists'),
        backgroundColor: Colors.green[700],
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _places.isEmpty
              ? Center(
                  child: Text(
                    'No dermatologists found nearby.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: _places.length,
                  itemBuilder: (context, index) {
                    final place = _places[index];
                    final name = place['name'] ?? 'No Name';
                    final vicinity = place['vicinity'] ?? 'Address not available';

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(vicinity),
                        trailing: Icon(Icons.directions, color: Colors.green[700]),
                        onTap: () => _openGoogleMaps(vicinity),
                      ),
                    );
                  },
                ),
    );
  }
}
