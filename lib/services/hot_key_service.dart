import 'package:dio/dio.dart';
import 'package:flutter_project/models/hot_keys_data.dart';
import 'package:flutter_project/models/search_data.dart';
import 'package:flutter_project/models/websites_data.dart';
import 'package:flutter_project/utils/http/http_util.dart';

class HotKeyService {
  static final HotKeyService _instance = HotKeyService._();

  factory HotKeyService() => _instance;

  HotKeyService._();

  final HttpUtil _httpInstance = HttpUtil();

  Future<List<WebsitesData>?> getWebsiteList() async {
    final Response res = await _httpInstance.get(path: "/friend/json");
    WebsitesDataList websitesData = WebsitesDataList.fromJson(res.data);
    return websitesData.websites;
  }

  Future<List<HotKeysData>?> getHotKeyList() async {
    final Response res = await _httpInstance.get(path: "/hotkey/json");
    HotKeysDataList hotKeysData = HotKeysDataList.fromJson(res.data);
    return hotKeysData.hotkeys;
  }

  Future<List<SearchDataItem>?> doSearch(String? keyword) async {
    final Response res = await _httpInstance
        .post(path: "/article/query/0/json", queryParameters: {'k': keyword});
    SearchDataList list = SearchDataList.fromJson(res.data);
    return list.datas;
  }
}
