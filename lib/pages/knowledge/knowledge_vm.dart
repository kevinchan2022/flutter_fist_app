import 'package:flutter/material.dart';
import 'package:flutter_project/models/knowledge_data.dart';
import 'package:flutter_project/services/knowledge_service.dart';

class KnowledgeVM extends ChangeNotifier {
  List<KnowledgeData>? knowledgeList = [];
  KnowledgeService knowledgeService = KnowledgeService();

  Future getKnowledge() async {
    List<KnowledgeData>? list = await knowledgeService.getKnowledgeData();
    knowledgeList = list ?? [];
    notifyListeners();
  }

  String handleSubTitle(List<KnowledgeChildren>? children) {
    if (children == null || children.isEmpty == true) {
      return "";
    }
    StringBuffer stringBuffer = StringBuffer('');
    for (var item in children) {
      stringBuffer.write("${item.name} ");
    }
    return stringBuffer.toString();
  }
}
