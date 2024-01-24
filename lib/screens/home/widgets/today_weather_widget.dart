import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/providers/geo_provider.dart';
import 'package:openclima/screens/widgets/inputs/search_input.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class TodayWeatherWidget extends StatefulWidget {
  const TodayWeatherWidget({super.key});

  @override
  State<TodayWeatherWidget> createState() => _TodayWeatherWidgetState();
}

class _TodayWeatherWidgetState extends State<TodayWeatherWidget> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final geoProvider = Provider.of<GeoProvider>(context);
    const String defaultAnimation = 'assets/animations/sun.json';

    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 300,
          color: scaffoldBackgroundColor,
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 100.w,
            height: 120,
            color: Colors.orange,
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
          width: 100.w,
          child: Column(
            children: [
              SearchInput(
                prefixIcon: Icons.location_on_outlined,
                searchController: searchController,
                // suffixIcon: Icons.settings_outlined,
                // buttonText: "",
                // accion: () {},
              ),
              Padding(
                padding: EdgeInsets.only(top: kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Ahora"),
                        Row(
                          children: [
                            Countup(
                              begin: 0,
                              end: geoProvider.wheaterData['temp_c'],
                              duration: const Duration(seconds: kDefaultTime~/2),
                              style: TextStyle(
                                fontSize: 50.sp, fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "°",
                              style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w600),
                            ),
                            Lottie.asset(
                              defaultAnimation,
                              width: 50.sp,
                              height: 50.sp,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                        const Text("Maxima: 24°/ Minima: 18°"),
                      ],
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Soleado"),
                        Text("Se siente como 23°"),
                      ]
                    ),
                  ],
                ),
              ),
            ],
          )
        )
      ],
    );
  }
}
