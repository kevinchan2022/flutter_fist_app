import 'package:flutter/material.dart';
import 'package:flutter_project/constants/storage_config.dart';
import 'package:flutter_project/services/auth_service.dart';
import 'package:flutter_project/utils/storage/storage_util.dart';

class MyViewModel extends ChangeNotifier {
  String? username;
  bool needLogin = false;

  final AuthService _authService = AuthService();

  // 获取本地保存的username
  Future initData() async {
    String? name = await StorageUtil.getString(StorageConfig.SP_USER_NAME);
    if (name == null || name == "") {
      username = '未登录';
      needLogin = true;
    } else {
      username = name;
      needLogin = false;
    }
    notifyListeners();
  }

  // 登出
  Future<bool> logout() async {
    bool isSuccess = await _authService.logout();
    if (isSuccess == true) {
      // 清除本地存储数据
      await StorageUtil.clear();
      return true;
    }
    return false;
  }
}
