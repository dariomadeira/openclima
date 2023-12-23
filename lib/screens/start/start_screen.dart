import 'package:flutter/material.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/screens/widgets/states/loading_widget.dart';
import 'package:openclima/services/shared_preferences_service.dart';

class StartScreen extends StatefulWidget {
  static const name = "start_screen";
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    final prefs = AppPreferences();
    final String storageLat = prefs.readPreferenceString(kBaseLat);
    final String storageLong = prefs.readPreferenceString(kBaseLong);
    Future.delayed(const Duration(seconds: 2), () async {
      if (storageLat.isEmpty || storageLong.isEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, "location");
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, "home");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Scaffold(
        body: Center(
          child: LoadingWidget()
        ),
      ),
    );
  }
}
