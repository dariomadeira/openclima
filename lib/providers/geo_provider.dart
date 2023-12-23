
import 'package:flutter/material.dart';

class GeoProvider with ChangeNotifier {
  factory GeoProvider() {
    return _thisInstance;
  }

  GeoProvider._internal();

  static final GeoProvider _thisInstance = GeoProvider._internal();

  bool isLoading = false;

  Future<void> getGeoLocation() async {
    isLoading = true;
    notifyListeners();
    


    await Future.delayed(const Duration(seconds: 5));
    isLoading = false;
    notifyListeners();
  }

}