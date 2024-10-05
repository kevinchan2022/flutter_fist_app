import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/collects_data.dart';
import 'package:flutter_project/services/home_service.dart';

class CollectsViewModel with ChangeNotifier {
  List<CollectsItemData> collectsList = [];

  int pageNum = 0;
  int pageSize = 5;

  final HomeService homeService = HomeService();

  Future initCollectData() async {
    pageNum = 0;
    collectsList.clear();
    List<CollectsItemData> list = await _getCollectsList(pageNum, pageSize);
    collectsList.addAll(list);
    // 更新
    notifyListeners();
  }

  // 加载更多
  Future<bool> loadMoreData() async {
    pageNum++;
    List<CollectsItemData> list = await _getCollectsList(pageNum, pageSize);
    collectsList.addAll(list);
    // 没有更多数据
    if (list.length < pageSize) {
      return false;
    }
    // 更新
    notifyListeners();
    return true;
  }

  Future<List<CollectsItemData>> _getCollectsList(int pageNum, int size) async {
    List<CollectsItemData>? list = await homeService.getCollects(pageNum, size);
    return list ?? [];
  }

  // 取消收藏
  Future cancelCollect(int index, int? id) async {
    bool isSuccess = await homeService.unCollect(id);
    if (isSuccess) {
      try {
        collectsList.removeAt(index);
        // 更新
        notifyListeners();
      } catch (e) {
        log('cancel Collect error:$e');
      }
    }
  }
}
