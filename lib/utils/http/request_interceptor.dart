import 'package:dio/dio.dart';
import 'package:flutter_project/models/response_model.dart';
import 'package:oktoast/oktoast.dart';

class RequestInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      // 如果是检查更新的接口,不做返回值前置的解析
      if (response.requestOptions.path.contains('apiv2/app/check')) {
        handler.next(response);
      } else {
        try {
          // 解析json
          var res = ResponseModel.fromJson(response.data);
          if (res.errorCode == 0) {
            // 接口返回的data是null的情况
            if (res.data == null) {
              handler.next(
                Response(requestOptions: response.requestOptions, data: true),
              );
            } else {
              handler.next(
                Response(
                    requestOptions: response.requestOptions, data: res.data),
              );
            }
          } else if (res.errorCode == -1001) {
            handler.reject(DioException(
                requestOptions: response.requestOptions, message: '未登录'));
            showToast('请先登录');
          } else if (res.errorCode == -1) {
            showToast(res.errorMsg ?? '');
            if (res.data == null) {
              handler.next(
                Response(requestOptions: response.requestOptions, data: false),
              );
            } else {
              handler.next(
                Response(
                    requestOptions: response.requestOptions, data: res.data),
              );
            }
          }
        } catch (e) {
          handler.reject(DioException(
              requestOptions: response.requestOptions, message: "$e"));
        }
      }
    } else {
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }
}
