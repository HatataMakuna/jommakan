import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
//import 'package:mapbox_gl/mapbox_gl.dart';

void main() {
  runApp(
    const MaterialApp(home: LocationPage()),
  );
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<StatefulWidget> createState() => _LocationState();
}

class _LocationState extends State<LocationPage> {
  bool mapToggle = false;

  //late Position currentLocation; // Define currentLocation here
  late MapController mapController;

  // Location package variables
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _userLocation;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    Location location = Location();

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await location.getLocation();
    if (mounted) {
      setState(() {
        _userLocation = locationData;
        mapToggle = true;
      });
    }
  }

  /* void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (mounted) {
      setState(() {
        currentLocation = position;
        mapToggle = true;
      });
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffeb324),
        title: const Text('Track Your Order'),
      ),
      body: Center(
        // ignore: sized_box_for_whitespace
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: mapToggle
              ? _loadMap()
              : _loading(),
        ),
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  Widget _loadMap() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(
          _userLocation.latitude!,
          _userLocation.longitude!,
        ),
        zoom: 17.0,
        minZoom: 5.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: LatLng(
                _userLocation.latitude!,
                _userLocation.longitude!,
              ),
              builder: (context) => const Icon(
                Icons.location_on,
                size: 40,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _loading() {
    return const Center(
      child: Text(
        'Loading... Please wait...',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}