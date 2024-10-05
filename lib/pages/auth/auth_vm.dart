import 'package:flutter/material.dart';
import 'package:flutter_project/constants/storage_config.dart';
import 'package:flutter_project/models/user_data.dart';
import 'package:flutter_project/services/auth_service.dart';
import 'package:flutter_project/utils/storage/storage_util.dart';
import 'package:oktoast/oktoast.dart';

class AuthViewModel with ChangeNotifier {
  RegisterInfo registerInfo = RegisterInfo();
  LoginInfo loginInfo = LoginInfo();

  final AuthService _authService = AuthService();

  void setLoginInfo({String? name, String? password}) {
    if (name != null) {
      loginInfo.name = name;
    }
    if (password != null) {
      loginInfo.password = password;
    }
  }

  Future<bool> register() async {
    if (registerInfo.name != null &&
        registerInfo.password != null &&
        registerInfo.rePassword != null &&
        registerInfo.password == registerInfo.rePassword) {
      if ((registerInfo.name?.length ?? 0) < 3) {
        showToast("账号长度必须大于等于3位");
        return false;
      } else if ((registerInfo.password?.length ?? 0) < 6) {
        showToast("密码长度必须大于等于6位");
        return false;
      } else {
        dynamic res = await _authService.register(
            name: registerInfo.name,
            password: registerInfo.password,
            rePassword: registerInfo.rePassword);
        return res is bool ? res : true;
      }
    } else {
      showToast('输入不能为空且密码必须一致');
      return false;
    }
  }

  Future<bool> login() async {
    UserData res = await _authService.login(
        username: loginInfo.name, password: loginInfo.password);
    if (res.username != null && res.username?.isNotEmpty == true) {
      // 本地保存登录数据
      StorageUtil.setString(StorageConfig.SP_USER_NAME, res.username ?? "");
      return true;
    } else {
      showToast('登陆失败');
      return false;
    }
  }
}

class RegisterInfo {
  String? name;
  String? password;
  String? rePassword;
}

class LoginInfo {
  String? name;
  String? password;
}
