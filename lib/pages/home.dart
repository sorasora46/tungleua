import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:tungleua/services/api.dart';
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

  List<Map<String, dynamic>>? stores;

  void handleTapOnMark(String storeId) {
    if (mounted) {
      showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          builder: (context) {
            return ShopBottomSheet(storeId: storeId);
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
    Api()
        .dio
        .get(
            "/stores/populate?offset=1&center_lat=13.7377383&center_long=100.5892962")
        .then((response) {
      final result = response.data['stores'] as List<dynamic>;
      final stores =
          result.map((data) => data as Map<String, dynamic>).toList();
      setState(() {
        this.stores = stores;
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

                      MarkerLayer(
                          rotate: true,
                          markers: stores!
                              .map((store) => Marker(
                                  point: LatLng(
                                      store['latitude'], store['longitude']),
                                  width: 80,
                                  height: 80,
                                  builder: (context) => GestureDetector(
                                        onTap: () =>
                                            handleTapOnMark(store['id']),
                                        child: const Icon(
                                          Icons.place,
                                          color: Colors.red,
                                          size: 32,
                                        ),
                                      )))
                              .toList()),
                      // MarkerLayer(rotate: true, markers: <Marker>[
                      //   Marker(
                      //       point: currentLocation!,
                      //       width: 80,
                      //       height: 80,
                      //       builder: (context) => GestureDetector(
                      //             onTap: handleTapOnMark,
                      //             child: const Icon(
                      //               Icons.place,
                      //               color: Colors.red,
                      //               size: 32,
                      //             ),
                      //           )),
                      // ]),
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
