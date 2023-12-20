
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



class Geolocation extends StatefulWidget {
  const Geolocation({super.key});

  @override
  State<Geolocation> createState() => _GeolocationState();
}

class _GeolocationState extends State<Geolocation> {
  String resultado = 'dario';
  Future<Position> determinePosition() async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied){
      return Future.error('error');
    }
    }
    final juanjo = await Geolocator.getCurrentPosition();
    inspect(juanjo);
    return juanjo;


  }

  void getCurrentLocation() async{
    Position position = await determinePosition();
     

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
      title: Text('localizacion'),
      
      centerTitle: true,
          

    ),
    body: Column(
      children: [
        FloatingActionButton(
          child: Text ('Tocame'),
          onPressed: (){
          final dario = determinePosition();
          setState(() {
            determinePosition().toString();
            
          });
          
          //determinePosition,
          }
          
        ),
        Text(determinePosition().toString()),
      ],
    ),
      
      
      
      
    );
    
  }
}
