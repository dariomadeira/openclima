import 'package:flutter/material.dart';
import 'package:openclima/config/geolocation/geo_location.dart';
import 'package:openclima/config/routers/app_reouters.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes,
      title: 'Material App',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const Geolocation(),
    );
  }
}