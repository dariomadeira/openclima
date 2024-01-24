import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openclima/config/routers/app_routers.dart';
import 'package:openclima/providers/geo_provider.dart';
import 'package:openclima/providers/theme_provider.dart';
import 'package:openclima/screens/start/start_screen.dart';
import 'package:openclima/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  final appPreferences = AppPreferences();
  await appPreferences.initPref();
  return runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('es'),
      ],
      fallbackLocale: const Locale('es'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(lazy: false, create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => GeoProvider()),
        ],
        child: const MyApp()
      ),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ThemeProvider>(context, listen: false).initTheme();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          routes: appRoutes,
          title: 'OpenClima',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            brightness: themeProvider.darkTheme ? Brightness.dark : Brightness.light,
            fontFamily: 'ProductSans',
            useMaterial3: true,
            colorSchemeSeed: Colors.yellow,
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
