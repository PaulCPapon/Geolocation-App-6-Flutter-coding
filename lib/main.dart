import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:geoflutterfire/geoflutterfire.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FireMap(),
      ),
    );
  }
}

class FireMap extends StatefulWidget {
  State createState() => FireMapState();
}

class FireMapState extends State<FireMap> {

  GoogleMapController mapController;
  Location location = new Location();

  build(context) {
   return Stack(children: <Widget>[
     GoogleMap(initialCameraPosition: CameraPosition(
         target: LatLng(24.142, -110.321),
       zoom: 15.0,
     ),
       onMapCreated: _onMapCreated,
       myLocationEnabled: true,
       mapType: MapType.terrain,
       trackCameraPosition: true,
     ),
     Positioned(
         bottom: 50.0,
         right: 10.0,
         child: FlatButton(onPressed: _addMarker, child: Icon(Icons.pin_drop, color: Colors.red,),
           color: Colors.green,
         ),

     )


   ],);
  }

  _onMapCreated(GoogleMapController controller) {

    setState(() {
      mapController = controller;
    });
  }


   _addMarker() {
    var marker = MarkerOptions(
        position: mapController.cameraPosition.target,
        icon: BitmapDescriptor.defaultMarker,
        infoWindowText: InfoWindowText("Magic Marker","" )
    );
    mapController.addMarker(marker);
  }

  _animateToUser() async {
    var pos = await location.getLocation();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(pos['latitude'], pos['longitude']),
      zoom: 17.0
    )));
  }

}