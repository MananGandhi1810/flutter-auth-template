class NetworkResponseModel {
  int statusCode;
  bool success;
  String message;
  dynamic data;

  NetworkResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    this.data,
  });

  post() {}
}
