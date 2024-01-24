import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/config/helpers/colors_helper.dart';
import 'package:openclima/providers/geo_provider.dart';
import 'package:openclima/providers/theme_provider.dart';
import 'package:openclima/screens/home/config/weather_items.dart';
import 'package:openclima/screens/widgets/areas/divider_title_widget.dart';
import 'package:openclima/screens/widgets/tiles/square_tile.dart';
// import 'package:openclima/screens/widgets/buttons/squeare_btn_widget.dart';
import 'package:openclima/screens/widgets/tiles/weather_tile.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final geoProvider = Provider.of<GeoProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorsHelper = ColorsHelper();
    final weatherConfig = WeatherConfig();
    // final Color textColors = colorsHelper.darken(
    //   color: geoProvider.weatherTypeSelected["options"][0]["headerColor"],
    //   amount: 0.5,
    // );
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.surfaceTint,
      fontSize: 60.sp,
      fontWeight: FontWeight.w600
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return FocusDetector(
      onVisibilityGained: () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarIconBrightness: themeProvider.darkTheme ? Brightness.light : Brightness.dark,
          statusBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: themeProvider.darkTheme ? Brightness.light : Brightness.dark,
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        ));
      },      
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 0.0,
          onPressed: () {},
          child: Icon(
            Icons.refresh_outlined,
            color: themeProvider.darkTheme ? null : Theme.of(context).primaryColor,
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: MySliverAppBar(expandedHeight: 300, geoProvider: geoProvider, temperatureStyle: textStyle),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 4.w, bottom: 4.w * 5),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final configItem = weatherConfig.weatherItems(geoProvider: geoProvider)[index];
                    final title = configItem["title"] as String;
                    final items = configItem["items"] as List;
                    final filteredItems = items.where((item) => item['hidden'] == false).toList();
                    final gridItems = filteredItems.where((item) => item['isGrid'] == true).toList();
                    final listItems = filteredItems.where((item) => item['isGrid'] == false).toList();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: kDefaultPadding),
                        DividerTitleWidget(
                          title: title,
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // number of items in each row
                            mainAxisSpacing: kDefaultPadding / 2, // spacing between rows
                            crossAxisSpacing: kDefaultPadding/2,
                            childAspectRatio: 100.w / (100.h / 2.8),
                          ),
                          // padding: const EdgeInsets.all(8.0), // padding around the grid
                          itemCount: gridItems.length, // total number of items
                          itemBuilder: (context, index) {
                            // return Container(
                            //   color: Colors.blue, // color of grid items
                            //   child: Center(
                            //     child: Text(
                            //       "mierda1",
                            //       style: const TextStyle(fontSize: 18.0, color: Colors.white),
                            //     ),
                            //   ),
                            // );
                            return SquareTile(
                              title: gridItems[index]["title"],
                              subtitle: gridItems[index]["subtitle"],
                              value: gridItems[index]["data"],
                              assetImage: gridItems[index]["assetImage"],
                            );
                          },
                        ),
                        ListView.builder(
                          padding: EdgeInsets.only(top: kDefaultPadding / 2),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: listItems.length,
                          itemBuilder: (_, index) {
                            return Column(
                              children: [
                                WeatherTile(
                                  title: listItems[index]["title"],
                                  value: listItems[index]["data"],
                                  assetImage: listItems[index]["assetImage"],
                                  subtitle: listItems[index]["subtitle"],
                                ),
                                SizedBox(height: kDefaultPadding/2),
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                  childCount: weatherConfig.weatherItems(geoProvider: geoProvider).length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final GeoProvider geoProvider;
  final TextStyle temperatureStyle;

  MySliverAppBar({required this.expandedHeight, required this.geoProvider, required this.temperatureStyle});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      height: maxExtent,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.6),
            ),
          ),
          Positioned(
            right: kDefaultPadding,
            bottom: kDefaultPadding * 6,
            child: Row(
              children: [
                Countup(
                  begin: 0,
                  end: geoProvider.wheaterData['temp_c'],
                  duration: const Duration(seconds: kDefaultTime ~/ 2),
                  style: temperatureStyle,
                ),
                Text(
                  "°",
                  style: temperatureStyle,
                ),
              ],
            ),
          ),
          // Positioned(
          //   left: kDefaultPadding / 1.6,
          //   bottom: kDefaultPadding,
          //   child: SvgPicture.asset(
          //     geoProvider.weatherTypeSelected['weatherAssets'][0],
          //     semanticsLabel: 'Detail',
          //     width: 70.w,
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
