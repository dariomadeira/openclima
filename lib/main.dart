import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openclima/screens/location/select_location.dart';
import 'package:openclima/config/routers/app_routers.dart';
import 'package:openclima/screens/start/start_screen.dart';
import 'package:openclima/services/shared_preferences_service.dart';
import 'package:sizer/sizer.dart';

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
    );
  }
}
