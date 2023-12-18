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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            FloatingActionButton (
              
              
              
              shape: const Border.symmetric() ,
              
              onPressed:() => Navigator.pushNamed(context, 'location'),
              child: const Text('Location'),
              
               ),
               
               

          ],
        ),
      ),
    );
  }
}