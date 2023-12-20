
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



class Geolocation extends StatefulWidget {
  const Geolocation({super.key});

  @override
  State<Geolocation> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  Future<Position> determinePosition() async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied){
      return Future.error('error');
    }
    }
    return await Geolocator.getCurrentPosition();


  }

  void getCurrentLocation() async{
    Position position = await determinePosition();
     

  }

  @override
  Widget build(BuildContext context) {
    Position? _currentLocation;
    late bool servicePermission = false;
    late LocationPermission permission;
    String _currentAdress = '';



    return Scaffold(
        appBar: AppBar(
          
      title: Text('localizacion'),
      
      centerTitle: true,
          

    ),
    body: Column(
      children: [
        FloatingActionButton(
          child: Text ('Tocame'),
          onPressed: () async {
        _currentLocation = await determinePosition();
          inspect(_currentLocation); 
          setState(() {
            _currentAdress = _currentLocation!.latitude.toString();
          });
          }
          
        ),
        
      Text(_currentAdress)
      ],
      
    ),
      
      
      
      
    );
    
  }
}
