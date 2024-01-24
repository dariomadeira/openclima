import 'package:flutter/material.dart';
import 'package:openclima/screens/home/home_screen.dart';
import 'package:openclima/screens/location/select_location.dart';
import 'package:openclima/screens/start/start_screen.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "home": (_) => const HomeScreen(),
  "location": (_) => const SelectLocation(),
  "start": (_) => const StartScreen(),
};
