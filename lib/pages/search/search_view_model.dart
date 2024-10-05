import 'package:flutter/material.dart';
import 'package:flutter_project/models/search_data.dart';
import 'package:flutter_project/services/hot_key_service.dart';

class SearchViewModel extends ChangeNotifier {
  List<SearchDataItem>? searchList;

  final HotKeyService _hotKeyService = HotKeyService();

  Future keywordSeach(String? keyword) async {
    List<SearchDataItem>? list = await _hotKeyService.doSearch(keyword);
    searchList = list ?? [];
    notifyListeners();
  }

  void clearSearchList() {
    searchList?.clear();
    notifyListeners();
  }
}
