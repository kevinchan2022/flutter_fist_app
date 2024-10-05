import 'package:dio/dio.dart';
import 'package:flutter_project/models/user_data.dart';
import 'package:flutter_project/utils/http/http_util.dart';

class AuthService {
  static final AuthService _instance = AuthService._();

  factory AuthService() => _instance;

  AuthService._();

  final HttpUtil _httpInstance = HttpUtil();

  Future<dynamic> register(
      {String? name, String? password, String? rePassword}) async {
    final Response res = await _httpInstance.post(
        path: "/user/register",
        queryParameters: {
          "username": name,
          "password": password,
          "repassword": rePassword
        });
    return res.data;
  }

  Future<UserData> login({String? username, String? password}) async {
    final Response res =
        await _httpInstance.post(path: "/user/login", queryParameters: {
      "username": username,
      "password": password,
    });
    UserData userData = UserData.fromJson(res.data);
    return userData;
  }

  // 登出
  Future<bool> logout() async {
    final Response res = await _httpInstance.get(path: "/user/logout/json");
    if (res.data != null && res.data is bool) {
      return res.data;
    } else {
      return false;
    }
  }
}
