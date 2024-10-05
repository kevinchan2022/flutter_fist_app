import 'package:flutter/material.dart';
import 'package:flutter_project/models/home_list_data.dart';
import 'package:flutter_project/services/home_service.dart';
import 'package:flutter_project/models/home_banner_data.dart';

class HomeViewModel with ChangeNotifier {
  List<HomeBannerItem>? bannerList;
  List<HomeListItem>? homeList = [];

  int pageNum = 0;
  int pageSize = 10;

  final HomeService _homeService = HomeService();

  Future getBanner() async {
    List<HomeBannerItem>? list = await _homeService.getBanner();
    bannerList = list ?? [];

    // 通知provider 观察的值发生变化
    notifyListeners();
  }

  Future initListData() async {
    pageNum = 0;
    homeList?.clear();

    List<HomeListItem>? topList = await getTopList();
    // 先获取置顶数据
    homeList?.addAll(topList ?? []);
    List<HomeListItem> list = await getHomeList(pageNum, pageSize);
    homeList?.addAll(list);

    // 更新
    notifyListeners();
  }

  Future<bool> loadMoreData() async {
    pageNum++;
    List<HomeListItem> list = await getHomeList(pageNum, pageSize);
    homeList?.addAll(list);
    // 没有更多数据了
    if (list.length < pageSize) {
      return false;
    }
    // if (pageNum == 2) {
    //   return false;
    // }
    // 更新
    notifyListeners();
    return true;
  }

  Future<List<HomeListItem>> getHomeList(pageNum, pageSize) async {
    List<HomeListItem>? list =
        await _homeService.getHomeList(pageNum, pageSize);
    if (list != null && list.isNotEmpty) {
      return list;
    } else {
      return [];
    }
  }

  Future<List<HomeListItem>?> getTopList() async {
    List<HomeListItem>? list = await _homeService.getHomeTopList();
    return list;
  }

  Future collectOrNot(bool isCollect, int? id, int index) async {
    bool? isSuccess;
    if (isCollect == true) {
      isSuccess = await _homeService.doCollect(id);
    } else {
      isSuccess = await _homeService.unCollect(id);
    }
    if (isSuccess == true) {
      homeList?[index].collect = isCollect;
      // 更新状态
      notifyListeners();
    }
  }
}
