import 'package:flutter/material.dart';
import 'package:openclima/screens/extended_weather.dart';
import 'package:openclima/screens/home_screen.dart';
import 'package:openclima/screens/select_location.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "home": (_) => const HomeScreen(),
  "extended": (_) => const ExtendedWeather(),
  "location": (_) => const SelectLocation(),
};
