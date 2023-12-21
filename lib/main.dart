import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:openclima/config/routers/app_reouters.dart';
import 'package:openclima/screens/select_location.dart';
=======
import 'package:google_fonts/google_fonts.dart';
import 'package:openclima/config/routers/app_routers.dart';
import 'package:openclima/screens/home_screen.dart';
import 'package:openclima/screens/select_location.dart';
import 'package:openclima/services/shared_preferences_service.dart';
>>>>>>> WIP/appIcon

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
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
=======
      theme: ThemeData(
        textTheme: GoogleFonts.josefinSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
>>>>>>> WIP/appIcon
      home: const SelectLocation(),
    );
  }
}
