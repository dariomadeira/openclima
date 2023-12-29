import 'package:dio/dio.dart';
import 'package:openclima/config/constants.dart';
import 'package:openclima/config/helpers/http_responses_helper.dart';

class WheaterApi {

  final Dio _dio = Dio();
  final String _authKey = kWeatherKey;

  Future<HttpResponses> getWeather({
    required String lat,
    required String long,
  }) async {
    try {
      String weatherUrl = "https://api.weatherapi.com/v1/current.json?key=$_authKey&q=$lat,$long";
      final response = await _dio.get(weatherUrl);
      return HttpResponses.success(response.data);
    } catch(e) {
      int statusCode = -1;
      String message = "Error desconocido";
      dynamic data;
      if (e is DioException) {
        message = e.message ?? "Error no especificado";
        if (e.response != null) {
          statusCode = e.response?.statusCode ?? statusCode;
          message = e.response?.statusMessage ?? message;
          data = e.response?.data;
        }
      }
      return HttpResponses.fail(
        statusCode: statusCode,
        message: message,
        data: data
      );
    }
  }

}