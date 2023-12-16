import 'package:flutter/material.dart';
import 'package:openclima/config/routers/app_reouters.dart';
import 'package:openclima/screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes,
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}