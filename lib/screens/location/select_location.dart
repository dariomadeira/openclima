import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/config/helpers/colors_helper.dart';
import 'package:openclima/customs/snacks_customs.dart';
import 'package:openclima/providers/geo_provider.dart';
import 'package:openclima/screens/widgets/inputs/search_input.dart';
import 'package:openclima/screens/widgets/states/loading_widget.dart';
import 'package:openclima/screens/widgets/tiles/custom_tile.dart';
import 'package:openclima/services/shared_preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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

  @override
  void initState() {
    googlePlace = GooglePlace(kGooglePlacesApiKey);
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
        showSnackbar(type: "success", message: 'Hemos obtenido tu ubicación', context: context);
        if (dataBoolean) {
          await Future.delayed(const Duration(seconds: kSortTime));
          getWeather();
        }
      }
    }

    return Scaffold(
      appBar: !geoProvider.isLoading
          ? AppBar(
              title: const Text("Busque su ubicación"),
            )
          : null,
      body: geoProvider.isLoading
          ? Center(
              child: FadeIn(
                child: LoadingWidget(
                  loadingMessage: geoProvider.loadingMessage,
                ),
              ),
            )
          : Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
                    width: 100.w,
                    color: scaffoldBackgroundColor,
                    child: SearchInput(
                      searchController: searchController,
                      accion: getGeoLocation,
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
                      child: ListView.builder(
                        padding: const EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
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
                              const SizedBox(height: kDefaultPadding),
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
