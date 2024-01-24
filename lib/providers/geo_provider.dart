import 'dart:developer';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:openclima/apis/weather_api.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/config/helpers/http_responses_helper.dart';
import 'package:openclima/providers/theme_provider.dart';
import 'package:openclima/services/shared_preferences_service.dart';

class GeoProvider with ChangeNotifier {
  factory GeoProvider() {
    return _thisInstance;
  }

  GeoProvider._internal();

  static final GeoProvider _thisInstance = GeoProvider._internal();

  bool isLoading = false;
  String loadingMessage = tr("location_loading_location");
  final weatherApi = WheaterApi();
  late Map<String, dynamic> wheaterData;
  late Map<String, dynamic> weatherTypeSelected;

  Future<Map<String, dynamic>> getGeoLocation() async {
    loadingMessage = tr("location_loading_latLong");
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> result = {
      'message': tr("location_loading_error"),
      'result': false,
    };
    await Future.delayed(const Duration(seconds: kSortTime));
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          result['message'] = tr("location_loading_error.authorize");
          isLoading = false;
          notifyListeners();
        }
      }
      final data = await Geolocator.getCurrentPosition();
      final bool savePref = await saveLocation(
        lat: data.latitude.toString(),
        long: data.longitude.toString(),
      );
      if (savePref) {
        result['message'] = tr("location_loading_success");
        result['result'] = true;
      }
    } catch (e) {
      result['message'] = tr("location_loading_error.unspected");
      isLoading = false;
      notifyListeners();
    }
    return result;
  }

  Future<bool> saveLocation({
    required String lat,
    required String long,
  }) async {
    if (isLoading == false) {
      loadingMessage = tr("location_save_latLog");
      isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: kSortTime));
    }
    bool result = false;
    final prefs = AppPreferences();
    prefs.savePreferenceString(kBaseLat, lat.toString());
    prefs.savePreferenceString(kBaseLong, long.toString());
    result = true;
    return result;
  }

  Future<Map<String, dynamic>> getWeather({
    required String lat,
    required String long,
  }) async {
    loadingMessage = tr("location_get_weather");
    notifyListeners();
    Map<String, dynamic> result = {
      'message': tr("location_get_weather.error"),
      'result': false,
    };
    final HttpResponses response = await weatherApi.getWeather(
      lat: lat,
      long: long,
    );
    if (response.data != null) {
      wheaterData = response.data['current'];
      result['message'] = tr("location_get_weather.success");
      inspect(wheaterData);
      bool detectResult = await detectWeatherType();
      if (detectResult) {
        result['result'] = true;
        final themeProvider = ThemeProvider();
        if (wheaterData['is_day'] == 1) {
          themeProvider.darkTheme = false;
        } else {
          themeProvider.darkTheme = true;
        }
      }
    }
    return result;
  }

  Future<bool> detectWeatherType() async {
    final actualTemp = wheaterData['feelslike_c'];
    bool result = false;
    final index = weatherHeaderSettings.indexWhere((weatherType) {
      final minTemp = weatherType["min"].toDouble();
      final maxTemp = weatherType["max"].toDouble();
      return actualTemp >= minTemp && actualTemp <= maxTemp;
    });
    if (index != -1) {
      Map<String, dynamic> processWeather = Map.from(weatherHeaderSettings[index]);
      result = await selectAssetsAndConfig(processWeather);
    }
    return result;
  }

  selectAssetsAndConfig(processWeather) {
    Random random = Random();
    Map<String, dynamic> selectedHeader = processWeather["options"][random.nextInt(processWeather["options"].length)];
    String selectedAsset = processWeather["weatherAssets"][random.nextInt(processWeather["weatherAssets"].length)];
    processWeather["options"] = [selectedHeader];
    processWeather["weatherAssets"] = [selectedAsset];
    weatherTypeSelected = processWeather;
    inspect(weatherTypeSelected);
    isLoading = false;
    return true;
  }
}
