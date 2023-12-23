import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:openclima/config/geolocation/geo_location.dart';
import 'package:openclima/config/routers/app_reouters.dart';

void main() => runApp(const MyApp());
=======
import 'package:google_fonts/google_fonts.dart';
import 'package:openclima/config/routers/app_routers.dart';
import 'package:openclima/providers/geo_provider.dart';
import 'package:openclima/screens/start/start_screen.dart';
import 'package:openclima/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appPreferences = AppPreferences();
  await appPreferences.initPref();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeoProvider()),
      ],
      child: const MyApp()
    )
  );
}
>>>>>>> 91065ceeb43c8a133f24e5d2da1116b56b3ad9e8

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      routes: appRoutes,
      title: 'Material App',
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const Geolocation(),
=======
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          routes: appRoutes,
          title: 'OpenClima',
          theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.josefinSansTextTheme(
              Theme.of(context).textTheme,
            ),
            colorSchemeSeed: Colors.teal,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
            )
          ),
          debugShowCheckedModeBanner: false,
          home: const StartScreen(),
        );
      }),
>>>>>>> 91065ceeb43c8a133f24e5d2da1116b56b3ad9e8
    );
  }
}