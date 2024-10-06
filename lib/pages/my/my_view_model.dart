import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/storage_config.dart';
import 'package:flutter_project/services/auth_service.dart';
import 'package:flutter_project/services/check_update_service.dart';
import 'package:flutter_project/utils/storage/storage_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MyViewModel extends ChangeNotifier {
  String? username;
  bool needLogin = false;
  bool showDot = true;

  final AuthService _authService = AuthService();
  final CheckUpdateService _checkUpdateService = CheckUpdateService();

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

  // 检查更新
  Future<String?> checkUpdate() async {
    PackageInfo info = await PackageInfo.fromPlatform();
    // 当前app的版本code
    String versionCode = info.buildNumber;

    // var model = await _checkUpdateService.checkUpdate();
    // 线上版本code
    // String onlineAppVersionCode = model?.data?.buildVersionNo ?? '0';
    String onlineAppVersionCode = '2';
    try {
      // 如果当前版本小于线上版本,需要更新
      if ((int.tryParse(versionCode) ?? 0) <
          (int.tryParse(onlineAppVersionCode) ?? 0)) {
        StorageUtil.setString(
            StorageConfig.SP_NEW_APP_VERSION, onlineAppVersionCode);
        // return model?.data?.downloadURL;
        return 'xxx';
      } else {
        StorageUtil.setString(StorageConfig.SP_NEW_APP_VERSION, versionCode);
        return null;
      }
    } catch (e) {
      log('check update error:$e');
      StorageUtil.setString(StorageConfig.SP_NEW_APP_VERSION, versionCode);
      return null;
    }
  }

  // 跳转外部浏览器
  Future jumpToOutLink(String? url) async {
    final uri = Uri.parse(url ?? '');
    bool canLanch = await canLaunchUrl(uri);
    if (canLanch) {
      return launchUrl(uri);
    } else {
      return null;
    }
  }

  // 是否显示更新红点
  void shouldShowUpdateDot() {
    showDot = !showDot;
    // 更新
    notifyListeners();
  }
}
