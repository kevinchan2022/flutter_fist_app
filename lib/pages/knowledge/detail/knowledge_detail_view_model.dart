import 'package:flutter/material.dart';
import 'package:flutter_project/models/knowledge_data.dart';
import 'package:flutter_project/models/knowledge_detail_data.dart';
import 'package:flutter_project/services/knowledge_service.dart';

class KnowledgeDetailViewModel with ChangeNotifier {
  List<Tab> tabs = [];
  List<KnowledgeDetailItem> detailItemList = [];

  int _pageNum = 0;
  final int _pageSize = 10;

  final KnowledgeService _knowledgeService = KnowledgeService();

  void intTabs(List<KnowledgeChildren>? tabList) {
    tabList?.forEach((item) {
      tabs.add(
        Tab(text: item.name?.trim() ?? ''),
      );
    });
  }

  Future initDetailData(int id) async {
    _pageNum = 0;
    detailItemList.clear();
    List<KnowledgeDetailItem> list = await getKnowledgeDetail(id);
    detailItemList.addAll(list);

    // 更新
    notifyListeners();
  }

  // 加载更多数据
  Future<bool> loadMore(int id) async {
    _pageNum++;
    List<KnowledgeDetailItem> list = await getKnowledgeDetail(id);
    detailItemList.addAll(list);
    // 没有更多数据了
    // if (list.length < _pageSize) {
    //   return false;
    // }
    // test load more
    if (_pageNum == 2) {
      return false;
    }
    // 更新
    notifyListeners();
    return true;
  }

  Future<List<KnowledgeDetailItem>> getKnowledgeDetail(int id) async {
    KnowledgeDetailData res = await _knowledgeService.getKnowledgeDetail(
        pageNum: _pageNum, id: id, pageSize: _pageSize);
    List<KnowledgeDetailItem>? list = res.datas;
    if (list != null && list.isNotEmpty) {
      return list;
    } else {
      return [];
    }
  }
}
