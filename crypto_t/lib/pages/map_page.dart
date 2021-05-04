import 'package:crypto_t/apis/session.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'app_routes.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  late GoogleMapController mapController;

  final Set<Marker> _markers = Set();

  void updateMarkers() {
    _markers.clear();
    Session.shared.getLocalAssets()?.forEach((asset) {
      var event = asset.suggestedEvent;
      if (event != null) {
        final marker = Marker(
          markerId: MarkerId(asset.id),
          position: LatLng(
            double.parse(event.latitude),
            double.parse(event.longitude),
          ),
          infoWindow: InfoWindow(
            title: asset.name,
            snippet: event.note,
            onTap: () async {
              await Navigator.pushNamed(context, AppRoutes.details, arguments: asset.id);
              setState(() {
                updateMarkers();
              });
            },
          ),
        );
        _markers.add(marker);
      }
    });
  }


  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    setState(() {
      updateMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      markers: _markers,
      initialCameraPosition: CameraPosition(
        target: const LatLng(0, 0),
        zoom: 0.0,
      ),
    );
  }
}