import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/services/shared_preferences_service.dart';

class GeoProvider with ChangeNotifier {
  factory GeoProvider() {
    return _thisInstance;
  }

  GeoProvider._internal();

  static final GeoProvider _thisInstance = GeoProvider._internal();

  bool isLoading = false;
  String loadingMessage = '';

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
        }
      }
      final data = await Geolocator.getCurrentPosition();
      inspect(data);
      final bool savePref = await saveLocation(
        lat: data.latitude.toString(),
        long: data.longitude.toString(),
      );
      if (savePref) {
        result['message'] = 'Hemos obtenido tu ubicación';
        result['result'] = true;
        inspect(result);
      }
    } catch (e) {
      // print("**** ERROR OBTENIENDO UBICACION ****");
      result['message'] = 'Error inesperado obteniendo ubicación';
    }
    isLoading = false;
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
    isLoading = false;
    return result;
  }
}
