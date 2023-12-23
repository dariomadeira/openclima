import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Geolocation extends StatefulWidget {
  const Geolocation({super.key});

  @override
  State<Geolocation> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  String currentAdress = 'dario';


  @override
  Widget build(BuildContext context) {
    Position? currentLocation;

    return Scaffold(
      appBar: AppBar(
        title: const Text('localizacion'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FloatingActionButton(
              child: const Text('Tocame'),
              onPressed: () async {
                currentLocation = await determinePosition();
                inspect(currentLocation);
                setState(() {
                  currentAdress = currentLocation!.latitude.toString();
                });
              }),
          Text(currentAdress)
        ],
      ),
    );
  }
}
