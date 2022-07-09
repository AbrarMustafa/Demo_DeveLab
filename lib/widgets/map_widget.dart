import 'package:demo_develab/widgets/dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({ Key? key }) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    // _location.onLocationChanged.listen((l) {
    //   _controller.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 15),
    //     ),
    //   );
    // });
  }


  @override
  Widget build(BuildContext context) {
    List<Marker> _markers = <Marker>[];

    covidResults.forEach((element) {
      _markers.add(
          Marker(
              markerId: MarkerId(element.Lat.toString()),
              position: LatLng(double.parse(element.Lat),double.parse(element.Lon) ),
              infoWindow: InfoWindow(
                  title: 'Active: ${element.Active} _ Deaths: ${element.Deaths}'
              )
          )
      );
    });
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              markers: Set<Marker>.of(_markers),
              initialCameraPosition: CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
            ),
          ],
        ),
      ),
    );
  }


}