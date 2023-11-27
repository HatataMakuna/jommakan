// TODO: Use flutter_map package

/*
[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: PlatformException(UNKNOWN_ERROR, The specified service does not exist as an installed service., null, null)
#0      MethodChannelGeolocator.getCurrentPosition
*/
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
        // ignore: sized_box_for_whitespace
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: mapToggle
              ? FlutterMap(
                options: MapOptions(
                  center: LatLng(
                    currentLocation.latitude,
                    currentLocation.longitude
                  ),
                  zoom: 19.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
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
