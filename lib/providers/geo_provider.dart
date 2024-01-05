import 'dart:developer';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:openclima/apis/weather_api.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/config/helpers/http_responses_helper.dart';
import 'package:openclima/services/shared_preferences_service.dart';
// import 'dart:convert';

class GeoProvider with ChangeNotifier {
  factory GeoProvider() {
    return _thisInstance;
  }

  GeoProvider._internal();

  static final GeoProvider _thisInstance = GeoProvider._internal();

  bool isLoading = false;
  String loadingMessage = 'Cargando ubicación';
  final weatherApi = WheaterApi();
  late Map<String, dynamic> wheaterData;
  late Map<String, dynamic> weatherTypeSelected;

  Future<Map<String, dynamic>> getGeoLocation() async {
    loadingMessage = "Detectando coordenadas";
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> result = {
      'message': 'No pudimos obtener tu ubicación',
      'result': false,
    };
    await Future.delayed(const Duration(seconds: kSortTime));
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          result['message'] = 'Necesitamos tu persmiso para obtener tu ubicación';
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
        result['message'] = 'Hemos obtenido tu ubicación';
        result['result'] = true;
      }
    } catch (e) {
      result['message'] = 'Error inesperado obteniendo ubicación';
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
      loadingMessage = "Guardando coordenadas";
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
    loadingMessage = "Obteniendo clima";
    notifyListeners();
    Map<String, dynamic> result = {
      'message': 'No pudimos obtener el clima',
      'result': false,
    };
    final HttpResponses response = await weatherApi.getWeather(
      lat: lat,
      long: long,
    );
    // print("**** RESPONSE ****");
    // inspect(response);
    if (response.data != null) {
      wheaterData = response.data['current'];
      result['message'] = 'Hemos obtenido el clima';
      // result['result'] = true;
      // inspect(result);
      // print(json.encode(result));
      // print("**** WHEATER DATA ****");
      inspect(wheaterData);
      bool detectResult = await detectWeatherType();
      if (detectResult) {
        result['result'] = true;
      }
    }
    return result;
  }

  Future<bool> detectWeatherType() async {
    final actualTemp = wheaterData['temp_c'];
    bool result = false;
    // print("**** ACTUAL TEMP **** $actualTemp");
    final index = weatherTypes.indexWhere((weatherType) {
      final minTemp = weatherType["min"].toDouble();
      final maxTemp = weatherType["max"].toDouble();
      return actualTemp >= minTemp && actualTemp <= maxTemp;
    });
    if (index != -1) {
      Map<String, dynamic> processWeather = Map.from(weatherTypes[index]);
      result = await selectOneBackground(processWeather);
    }
    return result;
  }

  selectOneBackground(processWeather) {
    Random random = Random();
    String selectedAsset = processWeather["asset"][random.nextInt(processWeather["asset"].length)];
    processWeather["asset"] = [selectedAsset];
    weatherTypeSelected = processWeather;
    // inspect(weatherTypeSelected);
    isLoading = false;
    return true;
  }
}
