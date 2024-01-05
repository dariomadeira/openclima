import 'package:flutter/material.dart';

const double kDefaultPadding = 20;
const int kDefaultTime = 4;
const int kSortTime = 2;
const Color kSnackSuccess = Color(0xFF53BD8C);
const String kGooglePlacesApiKey = "AIzaSyA_0BULRV-1AYr4BLTFbhGpC-fI1uSqw-4";
const String kWeatherKey = "ec23b57a160c4d07a70125728212705";

const String kBaseLat = 'lat';
const String kBaseLong = 'long';

const List<Map<String, dynamic>> weatherTypes = [
  {
    "name": "Caluroso",
    "asset": ["assets/svgs/calido.svg", "assets/svgs/calido1.svg", "assets/svgs/calido2.svg"],
    "color": Color(0xFF53BD8C),
    "min": 25,
    "max": 30,
  },
  {
    "name": "Caliente",
    "asset": ["assets/svgs/caliente.svg", "assets/svgs/caliente1.svg", "assets/svgs/calient2.svg"],
    "color": Color(0xFF53BD8C),
    "min": 31,
    "max": 100,
  },
  {
    "name": "Fresco",
    "asset": ["assets/svgs/fresco.svg", "assets/svgs/fresco1.svg", "assets/svgs/fresco2.svg"],
    "color": Color(0xFF53BD8C),
    "min": 18,
    "max": 24,
  },
  {
    "name": "Frio",
    "asset": ["assets/svgs/frio1.svg", "assets/svgs/frio2.svg", "assets/svgs/frio3.svg"],
    "color": Color(0xFF53BD8C),
    "min": -100,
    "max": 17,
  },
];


const List<Map<String, dynamic>> weatherHeaderSettings = [
  {
    "name": "Caluroso",
    "asset": ["assets/images/hot.png"],
    "appColor": Color(0xFF53BD8C),
    "min": 25,
    "max": 30,
  },
  {
    "name": "Caliente",
    "asset": ["assets/svgs/caliente.svg", "assets/svgs/caliente1.svg", "assets/svgs/calient2.svg"],
    "color": Color(0xFF53BD8C),
    "min": 31,
    "max": 100,
  },
  {
    "name": "Fresco",
    "asset": ["assets/svgs/fresco.svg", "assets/svgs/fresco1.svg", "assets/svgs/fresco2.svg"],
    "color": Color(0xFF53BD8C),
    "min": 18,
    "max": 24,
  },
  {
    "name": "Frio",
    "asset": ["assets/svgs/frio1.svg", "assets/svgs/frio2.svg", "assets/svgs/frio3.svg"],
    "color": Color(0xFF53BD8C),
    "min": -100,
    "max": 17,
  },
];