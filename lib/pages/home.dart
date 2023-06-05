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
        print('location has changed!\nevent: ${newLocation}');
      }
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
            : FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  center: currentLocation,
                  zoom: 16,
                ),
                nonRotatedChildren: [
                    FilledButton(
                        onPressed: () {},
                        child: Text(currentLocation.toString()))
                  ],
                children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    MarkerLayer(markers: <Marker>[
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
      ),
    );
  }
}
