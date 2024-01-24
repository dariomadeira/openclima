import 'package:easy_localization/easy_localization.dart';
import 'package:openclima/config/helpers/weather_helper.dart';
import 'package:openclima/providers/geo_provider.dart';

class WeatherConfig {
  final weatherHelper = WeatherHelper();

  String wheaterPath({
    required GeoProvider geoProvider,
  }) {
    String result;
    if (geoProvider.wheaterData['is_day'] == 1) {
      result = "Day";
    } else {
      result = "Night";
    }
    return result;
  }

  String windAsset({
    required String windAnalitycs,
  }) {
    String result;
    if (windAnalitycs == tr("wind_very_strong") || windAnalitycs == tr("wind_huraicane")) {
      result = "Windsock";
    } else {
      result = "Windsock Weak";
    }
    return result;
  }

  bool windImportant({
    required String windAnalitycs,
  }) {
    bool result;
    if (windAnalitycs == tr("wind_very_strong") || windAnalitycs == tr("wind_huraicane")) {
      result = true;
    } else {
      result = false;
    }
    return result;
  }

  List<dynamic> weatherItems({
    required GeoProvider geoProvider,
  }) {
    final String windSubtitle = weatherHelper.windAnalitics(wind: geoProvider.wheaterData['wind_kph']);
    final String humiditySubtitle = weatherHelper.humidityAnalitics(humidity: geoProvider.wheaterData['humidity'].toDouble());
    final String pressureSubtitle = weatherHelper.pressureAnalitics(pressure: geoProvider.wheaterData['pressure_mb'].toDouble());
    final String visibilitySubtitle = weatherHelper.visibilityAnalitics(visibility: geoProvider.wheaterData['vis_km'].toDouble());
    final String windDirectionSubtitle = weatherHelper.windDirectionAnalitics(direction: geoProvider.wheaterData['wind_dir']);
    final String windburstMaxSubtitle = weatherHelper.windBurstAnalitics(wind: geoProvider.wheaterData['gust_kph']);
    final String presipitationsSubtitle = weatherHelper.presipitationAnalitics(precipitation: geoProvider.wheaterData['precip_mm']);
    final String indexUVSubtitle = weatherHelper.indexUVAnalitics(indexUV: geoProvider.wheaterData['uv']);
    final String folderFileName = windAsset(windAnalitycs: windSubtitle);
    final configItems = [
      {
        "title": tr("more_info"),
        "items": [
          {
            "title": tr("termical_sensation"),
            'subtitle': geoProvider.weatherTypeSelected['name'],
            'data': "${geoProvider.wheaterData['feelslike_c']}°",
            "assetImage": "assets/icons/Miscellaneous/${wheaterPath(geoProvider: geoProvider)}/Thermometer/thermometer32x.png",
            "isGrid": true,
            "hidden": false,
          },
          {
            "title": tr("UV_index"),
            'subtitle': indexUVSubtitle,
            'data': "${geoProvider.wheaterData['uv']}",
            "assetImage": "assets/icons/Miscellaneous/Both/uv.png",
            "isGrid": true,
            "hidden": false,
          },
          {
            "title": tr("wind_speed"),
            'subtitle': windSubtitle,
            'data': "${geoProvider.wheaterData['wind_kph']} ${tr("wind_speed_unit")}",
            "assetImage": "assets/icons/Miscellaneous/${wheaterPath(geoProvider: geoProvider)}/$folderFileName/${folderFileName.toLowerCase()}32x.png",
            "isGrid": windImportant(windAnalitycs: windSubtitle),
            "hidden": false,
          },
          {
            "title": tr("precipitations"),
            'subtitle': presipitationsSubtitle,
            'data': "${geoProvider.wheaterData['precip_mm']} ${tr("milimeters")}",
            "assetImage": "assets/icons/Miscellaneous/${wheaterPath(geoProvider: geoProvider)}/Rainfall Measure/rainfall measure32x.png",
            "isGrid": false,
            "hidden": geoProvider.wheaterData['precip_mm'] <= 0.0 ? true : false,
          },
          {
            "title": "Nubes",
            'subtitle': presipitationsSubtitle,
            'data': "${geoProvider.wheaterData['cloud']}%",
            "assetImage": "assets/icons/Normal Conditions/${wheaterPath(geoProvider: geoProvider)}/Cloudy/cloudy32x.png",
            "isGrid": false,
            "hidden": false,
          },
          {
            "title": tr("wind_direction"),
            'subtitle': windDirectionSubtitle,
            'data': "${geoProvider.wheaterData['wind_degree']}°",
            "assetImage": "assets/icons/Miscellaneous/Both/windmill.png",
            "isGrid": windImportant(windAnalitycs: windSubtitle),
            "hidden": false,
          },
          {
            "title": tr("wind_speed_max"),
            'subtitle': windburstMaxSubtitle,
            'data': "${geoProvider.wheaterData['gust_kph']} Km/h",
            "assetImage": "assets/icons/Miscellaneous/Both/windDirection${wheaterPath(geoProvider: geoProvider)}.png",
            "isGrid": false,
            "hidden": false,
          },
          {
            "title": tr("humidity"),
            'subtitle': humiditySubtitle,
            'data': "${geoProvider.wheaterData['humidity']}%",
            "assetImage": "assets/icons/Miscellaneous/${wheaterPath(geoProvider: geoProvider)}/Humidity/humidity32x.png",
            "isGrid": false,
            "hidden": false,
          },
          {
            "title": tr("pressure"),
            'subtitle': pressureSubtitle,
            'data': "${geoProvider.wheaterData['pressure_mb']} Mb",
            "assetImage": "assets/icons/Miscellaneous/${wheaterPath(geoProvider: geoProvider)}/Rainfall Measure Alt/rainfall measure alt32x.png",
            "isGrid": false,
            "hidden": false,
          },
          {
            "title": tr("visibility"),
            'subtitle': visibilitySubtitle,
            'data': "${geoProvider.wheaterData['vis_km']} Km",
            "assetImage": "assets/icons/Miscellaneous/Both/visibility${wheaterPath(geoProvider: geoProvider)}.png",
            "isGrid": false,
            "hidden": false,
          },
        ]
      },
    ];
    return configItems;
  }
}
