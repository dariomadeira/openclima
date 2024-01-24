import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

double kDefaultPadding = 4.w;
const int kDefaultTime = 4;
const int kSortTime = 2;
const Color kSnackSuccess = Color(0xFF53BD8C);
const String kGooglePlacesApiKey = "AIzaSyA_0BULRV-1AYr4BLTFbhGpC-fI1uSqw-4";
const String kWeatherKey = "ec23b57a160c4d07a70125728212705";
const String kDarkModePref = "darkMode";

const String kBaseLat = 'lat';
const String kBaseLong = 'long';

const List<Map<String, dynamic>> weatherHeaderSettings = [
  {
    "name": "Caliente",
    "options": [
      // {
      //   "header": "assets/images/hot1.png",
      //   "bodyColor": Color(0xFF72C6F4),
      //   "headerColor": Color(0xFFFCDD51),
      //   "appBarIconsColorsDark": true,
      //   "navBarIconsColorsDark": true,
      // },
      // {
      //   "header": "assets/images/hot2.png",
      //   "bodyColor": Color(0xFF72C6F4),
      //   "headerColor": Color(0xFFFCDD51),
      //   "appBarIconsColorsDark": true,
      //   "navBarIconsColorsDark": true,
      // },
      {
        "header": "assets/images/hot3.png",
        "bodyColor": Color(0xFFFEE38A),
        "headerColor": Color(0xFFABEDF8),
        "appBarIconsColorsDark": true,
        "navBarIconsColorsDark": true,
      },
    ],
    "weatherAssets": ["assets/svgs/hotAsset1.svg", "assets/svgs/hotAsset2.svg"],
    "appColor": Colors.yellow,
    "min": 31.0,
    "max": 100.0,
  },
  {
    "name": "Caluroso",
    "options": [
      // {
      //   "header": "assets/images/hot1.png",
      //   "bodyColor": Color(0xFF72C6F4),
      //   "headerColor": Color(0xFFFCDD51),
      //   "appBarIconsColorsDark": true,
      //   "navBarIconsColorsDark": true,
      // },
      // {
      //   "header": "assets/images/hot2.png",
      //   "bodyColor": Color(0xFF72C6F4),
      //   "headerColor": Color(0xFFFCDD51),
      //   "appBarIconsColorsDark": true,
      //   "navBarIconsColorsDark": true,
      // },
      {
        "header": "assets/images/hot3.png",
        "bodyColor": Color(0xFFFEE38A),
        "headerColor": Color(0xFFABEDF8),
        "appBarIconsColorsDark": true,
        "navBarIconsColorsDark": true,
      },
    ],
    "weatherAssets": ["assets/svgs/hotAsset1.svg", "assets/svgs/hotAsset2.svg"],
    "appColor": Colors.yellow,
    "min": 25.0,
    "max": 30.9,
  },
  {
    "name": "Hermoso",
    "options": [
      // {
      //   "header": "assets/images/hot1.png",
      //   "bodyColor": Color(0xFF72C6F4),
      //   "headerColor": Color(0xFFFCDD51),
      //   "appBarIconsColorsDark": true,
      //   "navBarIconsColorsDark": true,
      // },
      // {
      //   "header": "assets/images/hot2.png",
      //   "bodyColor": Color(0xFF72C6F4),
      //   "headerColor": Color(0xFFFCDD51),
      //   "appBarIconsColorsDark": true,
      //   "navBarIconsColorsDark": true,
      // },
      {
        "header": "assets/images/hot3.png",
        "bodyColor": Color(0xFFFEE38A),
        "headerColor": Color(0xFFABEDF8),
        "appBarIconsColorsDark": true,
        "navBarIconsColorsDark": true,
      },
    ],
    "weatherAssets": ["assets/svgs/hotAsset1.svg", "assets/svgs/hotAsset2.svg"],
    "appColor": Colors.yellow,
    "min": 18.0,
    "max": 24.9,
  },
  {
    "name": "Frio",
    "options": [
      // {
      //   "header": "assets/images/hot1.png",
      //   "bodyColor": Color(0xFF72C6F4),
      //   "headerColor": Color(0xFFFCDD51),
      //   "appBarIconsColorsDark": true,
      //   "navBarIconsColorsDark": true,
      // },
      // {
      //   "header": "assets/images/hot2.png",
      //   "bodyColor": Color(0xFF72C6F4),
      //   "headerColor": Color(0xFFFCDD51),
      //   "appBarIconsColorsDark": true,
      //   "navBarIconsColorsDark": true,
      // },
      {
        "header": "assets/images/hot3.png",
        "bodyColor": Color(0xFFFEE38A),
        "headerColor": Color(0xFFABEDF8),
        "appBarIconsColorsDark": true,
        "navBarIconsColorsDark": true,
      },
    ],
    "weatherAssets": ["assets/svgs/hotAsset1.svg", "assets/svgs/hotAsset2.svg"],
    "appColor": Colors.yellow,
    "min": -100.0,
    "max": 17.9,
  },
];