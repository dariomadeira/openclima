import 'package:easy_localization/easy_localization.dart';

class WeatherHelper {

  String windAnalitics({
    required double wind,
  }) {
    String result = "";
    if (wind < 20.9) {
      result = tr("wind_soft");
    }
    if (wind > 21 && wind < 39.9) {
      result = tr("wind_moderate");
    }
    if (wind > 40 && wind < 69.9) {
      result = tr("wind_strong");
    }
    if (wind > 70 && wind < 119.9) {
      result = tr("wind_very_strong");
    }
    if (wind > 120) {
      result = tr("wind_huraicane");
    }
    return result;
  }

  String windBurstAnalitics({
    required double wind,
  }) {
    String result = "";
    if (wind < 20.9) {
      result = tr("wind_burst_soft");
    }
    if (wind > 21 && wind < 39.9) {
      result = tr("wind_burst_moderate");
    }
    if (wind > 40 && wind < 69.9) {
      result = tr("wind_burst_strong");
    }
    if (wind > 70 && wind < 119.9) {
      result = tr("wind_burst_very_strong");
    }
    if (wind > 120) {
      result = tr("wind_burst_huraicane");
    }
    return result;
  }

  String presipitationAnalitics({
    required double precipitation,
  }) {
    String result = "";
    if (precipitation < 2.0) {
      result = tr("precipitation_soft");
    }
    if (precipitation >= 2.1 && precipitation <= 15.0) {
      result = tr("precipitation_moderate");
    }
    if (precipitation >= 15.1 && precipitation <= 30.0) {
      result = tr("precipitation_strong");
    }
    if (precipitation >= 30.1 && precipitation <= 60.0) {
      result = tr("precipitation_very_strong");
    }
    if (precipitation >= 60.1) {
      result = tr("precipitation_torrencials");
    }
    return result;
  }  

  String windDirectionAnalitics({
    required String direction,
  }) {
    String result = "";
    switch (direction) {
      case "N":
        result = tr("wind_N");
        break;
      case "S":
        result = tr("wind_S");
        break;
      case "E":
        result = tr("wind_E");
        break;
      case "W":
        result = tr("wind_W");
        break;
      case "NE":
        result = tr("wind_NE");
        break;
      case "NW":
        result = tr("wind_NW");
        break;
      case "SE":
        result = tr("wind_SE");
        break;
      case "SW":
        result = tr("wind_SW");
        break;
      case "NNE":
        result = tr("wind_NNE");
        break;
      case "ENE":
        result = tr("wind_ENE");
        break;
      case "ESE":
        result = tr("wind_ESE");
        break;
      case "SSE":
        result = tr("wind_SSE");
        break;
      case "SSW":
        result = tr("wind_SSW");
        break;
      case "WSW":
        result = tr("wind_WSW");
        break;
      case "WNW":
        result = tr("wind_WNW");
        break;
      case "NNW":
        result = tr("wind_NNW");
        break;
      default:
    }
    return result;
  }

  String humidityAnalitics({
    required double humidity,
  }) {
    String result = "";
    if (humidity < 29.9) {
      result = tr("humidity_low");
    }
    if (humidity > 30 && humidity < 59.9) {
      result = tr("humidity_medium");
    }
    if (humidity > 60) {
      result = tr("humidity_high");
    }
    return result;
  }

  String pressureAnalitics({
    required double pressure,
  }) {
    String result = "";
    if (pressure < 1013.0) {
      result = tr("humidity_low");
    }
    if (pressure > 1013.1 && pressure < 1016.0) {
      result = tr("pressure_normal");
    }
    if (pressure > 1016.1) {
      result = tr("humidity_high");
    }
    return result;
  }

  String visibilityAnalitics({
    required double visibility,
  }) {
    String result = "";
    if (visibility < 1.0) {
      result = tr("visibility_reduce");
    }
    if (visibility > 1.1 && visibility < 4.0) {
      result = tr("visibility_moderate");
    }
    if (visibility > 4.1) {
      result = tr("visibility_good");
    }
    return result;
  }

  String indexUVAnalitics({
    required double indexUV,
  }) {
    String result = "";
    if (indexUV < 2.0) {
      result = tr("UV_index_min");
    }
    if (indexUV > 2.1 && indexUV <= 5.0) {
      result = tr("UV_index_low");
    }
    if (indexUV > 5.1 && indexUV <= 7.0) {
      result = tr("UV_index_medium");
    }
    if (indexUV > 7.1 && indexUV <= 10.0) {
      result = tr("UV_index_high");
    }
    if (indexUV > 10.1 && indexUV <= 14.0) {
      result = tr("UV_index_very_high");
    }
    if (indexUV > 14.1) {
      result = tr("UV_index_extreme");
    }
    return result;
  }  

}
