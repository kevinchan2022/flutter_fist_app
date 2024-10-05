class ResponseModel<T> {
  T? data;
  int? errorCode;
  String? errorMsg;

  ResponseModel.fromJson(dynamic json) {
    data = json['data'];
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }
}
