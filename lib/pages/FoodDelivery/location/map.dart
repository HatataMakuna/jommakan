import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:mapbox_gl/mapbox_gl.dart';

void main() {
  runApp(
    const MaterialApp(home: Location()),
  );
}

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<StatefulWidget> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool mapToggle = false;

  late Position currentLocation; // Define currentLocation here
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    // requires location
    /* Geolocator.getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
    }); */
    setState(() {
      mapToggle = true;
    });
  }

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
              ? FlutterMap(
                options: MapOptions(
                  center: LatLng(3.216, 101.727),/* currentLocation != null ? LatLng(
                    currentLocation.latitude,
                    currentLocation.longitude
                  ) : LatLng(0.0, 0.0) */
                  zoom: 17.0,
                  minZoom: 5.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ],
              )
              : const Center(
                  child: Text(
                    'Loading ..please Wait..',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
        ),
      ),
    );
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
