import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class PickLocation extends StatefulWidget {
  const PickLocation({Key? key, required this.setPosition}) : super(key: key);
  final void Function(LatLng position) setPosition;

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  final mapController = MapController();
  final location = Location();
  LatLng? originalLocation;
  LatLng? currentLocation;
  double zoom = 16;

  void handlePositionChange(MapPosition position, bool _) {
    setState(() {
      currentLocation = position.center;
    });
  }

  @override
  void initState() {
    super.initState();
    location.getLocation().then((locationData) {
      setState(() {
        currentLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
        originalLocation =
            LatLng(locationData.latitude!, locationData.longitude!);
      });
    });
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick your location')),
      body: SafeArea(
        child: currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: currentLocation!,
                    zoom: zoom,
                    onPositionChanged: handlePositionChange,
                  ),
                  children: <Widget>[
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(rotate: true, markers: <Marker>[
                      Marker(
                        point: currentLocation!,
                        width: 80,
                        height: 80,
                        builder: (context) => GestureDetector(
                          child: const Icon(
                            Icons.place,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Column(children: <Widget>[
                    IconButton(
                      onPressed: () {
                        mapController.rotate(0);
                      },
                      icon: const Icon(Icons.explore_outlined),
                      iconSize: 34,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          mapController.move(originalLocation!, zoom);
                        });
                      },
                      icon: const Icon(Icons.location_searching),
                      iconSize: 34,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          zoom++;
                          mapController.move(currentLocation!, zoom);
                        });
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 34,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          zoom--;
                          mapController.move(currentLocation!, zoom);
                        });
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 34,
                    ),
                  ]),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Row(children: [
                    FilledButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 10),
                    FilledButton(
                      onPressed: () {
                        widget.setPosition(currentLocation!);
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    ),
                  ]),
                ),
              ]),
      ),
    );
  }
}
