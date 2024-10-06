import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_project/constants/http_config.dart';
import 'package:flutter_project/utils/http/cookie_interceptor.dart';
import 'package:flutter_project/utils/http/request_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();

  // 工厂函数
  factory HttpUtil() => _instance;

  late Dio _dio;

  // 私有命名构造函数
  HttpUtil._internal() {
    const defaultDelay = Duration(seconds: 30);
    BaseOptions options = BaseOptions(
      baseUrl: HttpConfig.BASE_URL,
      connectTimeout: defaultDelay,
      receiveTimeout: defaultDelay,
      sendTimeout: defaultDelay,
      responseType: ResponseType.json,
    );
    // 初始化dio
    _dio = Dio();
    _dio.options = options;
    // cookide拦截器
    _dio.interceptors.add(CookieInterceptor());
    // 日志拦截器
    if (!kReleaseMode) {
      PrettyDioLogger prettyDioLogger = PrettyDioLogger(
        requestHeader: false,
        requestBody: false,
        responseBody: false,
        responseHeader: false,
      );
      _dio.interceptors.add(prettyDioLogger);
    }
    // 请求拦截器
    _dio.interceptors.add(RequestInterceptor());
  }

  Future<Response> get({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options ?? Options(method: HttpConfig.GET),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options ?? Options(method: HttpConfig.POST),
      cancelToken: cancelToken,
      onReceiveProgress: onSendProgress,
      onSendProgress: onSendProgress,
    );
  }

  void changeBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }
}
