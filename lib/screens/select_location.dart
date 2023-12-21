import 'package:flutter/material.dart';
import 'package:openclima/screens/widgets/details/rounded_detail.dart';
import 'package:openclima/screens/widgets/title/custom_title.dart';

class SelectLocation extends StatelessWidget {
  const SelectLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("location"),
      ),
<<<<<<< HEAD
      body: const Center(
        child: SearchBar(hintText: 'Select Location'),
        
        

        

      ),
      
=======
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RoundedDetail(
            icon: Icons.location_on,
            color: Colors.red,
          ),
          RoundedDetail(
            icon: Icons.location_searching,
            color: Colors.green,
            size: 50,
          ),
          CustomTitle()
        ],
      )
>>>>>>> WIP/appIcon
    );
  }
}