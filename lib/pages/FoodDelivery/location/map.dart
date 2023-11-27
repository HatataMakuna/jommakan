import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

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

  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((currloc) {
      setState(() {
        currentLocation = currloc;
        mapToggle = true;
      });
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: mapToggle
              ? GoogleMap(
                  onMapCreated: onMapCreated,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      currentLocation.latitude,
                      currentLocation.longitude,
                    ),
                    zoom: 19.0,
                  ),
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
