import 'package:flutter/material.dart';
import 'package:flutter_project/models/hot_keys_data.dart';
import 'package:flutter_project/models/websites_data.dart';
import 'package:flutter_project/services/hot_key_service.dart';

class HotKeyVM with ChangeNotifier {
  List<WebsitesData>? websitesList;
  List<HotKeysData>? hotKeyList;

  HotKeyService hotKeyService = HotKeyService();

  Future initData() async {
    Future f1 = getWebsites();
    Future f2 = getHotKeys();
    await Future.wait([f1, f2]);
    notifyListeners();
  }

  Future getWebsites() async {
    List<WebsitesData>? websitesData = await hotKeyService.getWebsiteList();
    websitesList = websitesData ?? [];
  }

  Future getHotKeys() async {
    List<HotKeysData>? hotKeys = await hotKeyService.getHotKeyList();
    hotKeyList = hotKeys ?? [];
  }
}
