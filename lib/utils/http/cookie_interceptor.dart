import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_project/constants/storage_config.dart';
import 'package:flutter_project/utils/storage/storage_util.dart';

class CookieInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 获取本地存储的cookie
    final cookieList = await StorageUtil.getStringList(StorageConfig.SP_COOKIE);
    // 把cookie放到请求头中
    options.headers[HttpHeaders.cookieHeader] = cookieList;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.path.contains('/user/login')) {
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookieList = [];
      if (list is List) {
        for (String cookie in list) {
          cookieList.add(cookie);
        }
      }
      // 本地保存cookie
      StorageUtil.setStringList(StorageConfig.SP_COOKIE, cookieList);
    }
    super.onResponse(response, handler);
  }
}
