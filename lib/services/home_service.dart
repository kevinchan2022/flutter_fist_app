import 'package:dio/dio.dart';
import 'package:flutter_project/models/collects_data.dart';
import 'package:flutter_project/models/home_banner_data.dart';
import 'package:flutter_project/models/home_list_data.dart';
import 'package:flutter_project/utils/http/http_util.dart';

class HomeService {
  static final HomeService _instance = HomeService._();

  factory HomeService() => _instance;

  HomeService._();

  final HttpUtil _httpInstance = HttpUtil();

  Future<List<HomeBannerItem>?> getBanner() async {
    final Response res = await _httpInstance.get(path: "/banner/json");
    HomeBannerData bannerData = HomeBannerData.fromJson(res.data);
    return bannerData.bannerList;
  }

  Future<List<HomeListItem>?> getHomeList(int pageNum, int pageSize) async {
    final Response res = await _httpInstance.get(
      path: "/article/list/$pageNum/json",
      queryParameters: {"page_size": pageSize},
    );
    print('test');
    HomeListData listData = HomeListData.fromJson(res.data);
    return listData.datas;
  }

  /// 获取置顶数据
  Future<List<HomeListItem>?> getHomeTopList() async {
    final res = await _httpInstance.get(path: "/article/top/json");
    HomeTopListData listData = HomeTopListData.fromJson(res.data);
    return listData.topList;
  }

  // 收藏
  Future<bool> doCollect(int? id) async {
    final res = await _httpInstance.post(path: "/lg/collect/$id/json");
    if (res.data != null && res.data is bool) {
      return res.data;
    }
    return false;
  }

  // 取消收藏
  Future<bool> unCollect(int? id) async {
    final res =
        await _httpInstance.post(path: "/lg/uncollect_originId/$id/json");
    if (res.data != null && res.data is bool) {
      return res.data;
    }
    return false;
  }

  // 查询收藏列表
  Future getCollects(int pageNum) async {
    final res = await _httpInstance.get(path: "/lg/collect/list/$pageNum/json");
    var data = CollectsListData.fromJson(res.data);
    if (data.datas != null && data.datas?.isNotEmpty == true) {
      return data.datas;
    } else {
      return [];
    }
  }
}
