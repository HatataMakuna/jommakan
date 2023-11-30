import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
    const MaterialApp(home: Location()),
  );
}

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool mapToggle = false;

  late Position currentLocation;
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLocation = position;
        mapToggle = true;
      });
    } catch (e) {
      print('Error: $e');
    }
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
              ? FlutterMap(
                  options: MapOptions(
                    center: LatLng(
                      currentLocation.latitude,
                      currentLocation.longitude,
                    ),
                    zoom: 17.0,
                    minZoom: 5.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      // tileProvider: NonCachingNetworkTileProvider(),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    'Loading... Please wait...',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
        ),
      ),
    );
  }
}
