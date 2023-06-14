import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:tungleua/widgets/shop_bottom_sheet.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final mapController = MapController();
  final location = Location();
  LatLng? currentLocation;
  LatLng? currentMapPosition;
  double zoom = 16;

// TODO: Fetch data to ShopBottomSheet
  void handleTapOnMark() {
    if (mounted) {
      showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (context) {
            return const ShopBottomSheet();
          });
    }
  }

  Future<void> initCurrentLocation() async {
    final locationData = await location.getLocation();
    currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    location.onLocationChanged.listen((newLocation) {
      if (mounted) {
        setState(() {
          currentLocation =
              LatLng(newLocation.latitude!, newLocation.longitude!);
        });
        debugPrint('location has changed!\nevent: $newLocation');
      }
    });
  }

  void handleMapPositionChange(LatLng position) {
    setState(() {
      currentMapPosition = position;
    });
  }

  @override
  void initState() {
    super.initState();
    initCurrentLocation();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(children: [
                FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        center: currentLocation,
                        zoom: zoom,
                        onPositionChanged: (position, _) {
                          handleMapPositionChange(position.center!);
                        }),
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
                                  onTap: handleTapOnMark,
                                  child: const Icon(
                                    Icons.place,
                                    color: Colors.red,
                                    size: 32,
                                  ),
                                )),
                      ]),
                    ]),
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
                          mapController.move(currentLocation!, zoom);
                        });
                      },
                      icon: const Icon(Icons.location_searching),
                      iconSize: 34,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          zoom++;
                          mapController.move(currentMapPosition!, zoom);
                        });
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      iconSize: 34,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          zoom--;
                          mapController.move(currentMapPosition!, zoom);
                        });
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      iconSize: 34,
                    ),
                  ]),
                ),
              ]),
      ),
    );
  }
}
