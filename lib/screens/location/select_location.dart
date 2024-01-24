import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_place/google_place.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/config/helpers/colors_helper.dart';
import 'package:openclima/customs/snacks_customs.dart';
import 'package:openclima/providers/geo_provider.dart';
import 'package:openclima/screens/widgets/inputs/search_input.dart';
import 'package:openclima/screens/widgets/states/empty_widget.dart';
import 'package:openclima/screens/widgets/states/loading_widget.dart';
import 'package:openclima/screens/widgets/tiles/custom_tile.dart';
import 'package:openclima/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  final TextEditingController searchController = TextEditingController();
  final colorsHelper = ColorsHelper();
  bool isKeyboardVisible = false;

  @override
  void initState() {
    googlePlace = GooglePlace(kGooglePlacesApiKey);
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Color scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final geoProvider = Provider.of<GeoProvider>(context);

    Future<void> getWeather() async {
      final prefs = AppPreferences();
      final String storageLat = prefs.readPreferenceString(kBaseLat);
      final String storageLong = prefs.readPreferenceString(kBaseLong);
      final Map<String, dynamic> weatherData = await geoProvider.getWeather(
        lat: storageLat,
        long: storageLong,
      );
      if (weatherData['result']) {
        await Future.delayed(const Duration(seconds: kSortTime));
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      }
    }

    Future<void> getGeoLocation() async {
      final Map<String, dynamic> data = await geoProvider.getGeoLocation();
      // ignore: use_build_context_synchronously
      showSnackbar(type: data['result'] ? "success" : "error", message: data['message'], context: context);
      if (data['result']) {
        await Future.delayed(const Duration(seconds: kSortTime));
        getWeather();
      }
    }

    Future<void> selectGeoLocation({placeId}) async {
      var result = await googlePlace.details.get(placeId);
      if (result != null && mounted) {
        final bool dataBoolean = await geoProvider.saveLocation(
          lat: result.result!.geometry!.location!.lat.toString(),
          long: result.result!.geometry!.location!.lng.toString(),
        );
        // ignore: use_build_context_synchronously
        showSnackbar(type: "success", message: tr("location_snack_success"), context: context);
        if (dataBoolean) {
          await Future.delayed(const Duration(seconds: kSortTime));
          getWeather();
        }
      }
    }

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: !geoProvider.isLoading
          ? AppBar(
              title: Text(
                tr("location_title"),
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
            )
          : null,
      floatingActionButton: !geoProvider.isLoading
          ? FloatingActionButton.extended(
              elevation: 0.0,
              onPressed: getGeoLocation,
              label: Text(
                tr("location_button_detect"), 
                style: TextStyle(color: Theme.of(context).primaryColor)
              ),
              icon: Icon(Icons.my_location_outlined, color: Theme.of(context).primaryColor),
            )
          : null,
      body: geoProvider.isLoading
          ? FadeIn(
              child: LoadingWidget(
                loadingMessage: [geoProvider.loadingMessage],
              ),
            )
          : Column(
              children: [
                Container(
                    padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
                    width: 100.w,
                    color: scaffoldBackgroundColor,
                    child: SearchInput(
                      searchController: searchController,
                      onChanged: (String value) {
                        if (value.isNotEmpty) {
                          autoCompleteSearch(value);
                        } else {
                          if (predictions.isNotEmpty && mounted) {
                            setState(() {
                              predictions = [];
                            });
                          }
                        }
                      },
                    )),
                Expanded(
                  child: SizedBox(
                      width: 100.w,
                      child: predictions.isEmpty && !isKeyboardVisible
                          ? FadeIn(
                              child: EmptyWidget(
                                emptyMessage: [
                                  tr("location_empty_location_1"), 
                                  tr("location_empty_location_2"), 
                                  tr("location_empty_location_3")
                                ],
                                svgAsset: 'assets/svgs/emptyLocation.svg',
                                finalSpace: 6.h,
                              ),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
                              itemCount: predictions.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    CustomTile(
                                      title: predictions[index].structuredFormatting!.mainText!,
                                      subtitle: predictions[index].structuredFormatting!.secondaryText ?? "",
                                      icon: Icons.pin_drop_outlined,
                                      noEllipsis: true,
                                      color: colorsHelper.randomColor(),
                                      showEdit: true,
                                      editAccion: () {
                                        FocusScope.of(context).requestFocus(FocusNode());
                                        selectGeoLocation(placeId: predictions[index].placeId!);
                                      },
                                    ),
                                    SizedBox(height: kDefaultPadding / 2),
                                  ],
                                );
                              },
                            )),
                ),
              ],
            ),
    );
  }

  Future<void> autoCompleteSearch(String value) async {
    final result = await googlePlace.autocomplete.get(
      value,
      language: "es",
    );
    if (result != null && result.predictions != null && mounted) {
      if (predictions.isEmpty) {
        setState(() {
          predictions = result.predictions!;
        });
      } else {
        if (result.predictions!.length < predictions.length) {
          setState(() {
            predictions = result.predictions!;
          });
        } else {
          final set1 = Set.from(predictions);
          final set2 = Set.from(result.predictions!);
          final List<AutocompletePrediction> newPredictions = List.from(set2.difference(set1));
          setState(() {
            predictions = newPredictions;
          });
        }
      }
    }
  }
}
