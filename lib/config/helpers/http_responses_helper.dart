class HttpResponses {

  final dynamic data;
  final HttpErros error;

  HttpResponses(
    this.data,
    this.error
  );

  static HttpResponses success(
    dynamic data
  ) => HttpResponses(data, HttpErros(statusCode: 200, message: "", data: ""));

  static HttpResponses fail({
    required int statusCode,
    required String message,
    required dynamic data,
  }) => HttpResponses(null, HttpErros(statusCode: statusCode, message: message, data: data));
}

class HttpErros {

  final int statusCode;
  final String message;
  final dynamic data;

  HttpErros({
    required this.statusCode,
    required this.message,
    required this.data
  });

}
