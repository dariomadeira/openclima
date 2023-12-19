import 'package:flutter/material.dart';
import 'package:openclima/config/routers/app_routers.dart';
import 'package:openclima/screens/home_screen.dart';
import 'package:openclima/services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appPreferences = AppPreferences();
  await appPreferences.initPref();
  return runApp(const MyApp());
}

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
