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

  Map<String, dynamic> toJson() {
    return {
      "statusCode": statusCode,
      "success": success,
      "message": message,
      "data": data,
    };
  }
}
