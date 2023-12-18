import 'package:flutter/material.dart';

class ExtendedWeather extends StatelessWidget {
  const ExtendedWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("extended"),
      ),
      body: Center(
        child: FloatingActionButton(
          onPressed:() => Navigator.pushNamed(context, 'location'),
          child: const Text('Location'),
           ),
      ),
    );
  }
}