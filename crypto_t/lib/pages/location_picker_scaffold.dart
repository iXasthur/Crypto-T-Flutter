import 'package:crypto_t/utils/widget/my_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerScaffold extends StatefulWidget {
  @override
  _LocationPickerScaffoldState createState() => _LocationPickerScaffoldState();
}

class _LocationPickerScaffoldState extends State<LocationPickerScaffold> {

  late GoogleMapController mapController;

  LatLng _position = LatLng(0, 0);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onCameraMoved(CameraPosition position) {
    _position = position.target;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.createWithAutoBack(
        context,
        title: "Pick Location",
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pop(context, _position);
            },
            icon: Icon(CupertinoIcons.checkmark_alt),
            splashColor: Colors.transparent,
          ),
        ],
        onBack: () {

        },
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            onCameraMove: _onCameraMoved,
            initialCameraPosition: CameraPosition(
              target: const LatLng(0, 0),
              zoom: 0.0,
            ),
          ),
          Icon(CupertinoIcons.plus, color: Colors.blueAccent),
        ],
      ),
    );
  }
}
