import 'package:dio/dio.dart';
import 'package:flutter_project/models/knowledge_data.dart';
import 'package:flutter_project/models/knowledge_detail_data.dart';
import 'package:flutter_project/utils/http/http_util.dart';

class KnowledgeService {
  static final KnowledgeService _knowledgeService = KnowledgeService._();

  factory KnowledgeService() => _knowledgeService;

  KnowledgeService._();

  final HttpUtil _httpInstance = HttpUtil();

  Future<List<KnowledgeData>?> getKnowledgeData() async {
    final Response res = await _httpInstance.get(path: "/tree/json");
    KnowledgeListData data = KnowledgeListData.fromJson(res.data);
    return data.knowledgeList;
  }

  Future<KnowledgeDetailData> getKnowledgeDetail({
    required int pageNum,
    int? pageSize = 20,
    required int id,
  }) async {
    final Response res = await _httpInstance.get(
      path: "/article/list/$pageNum/json",
      queryParameters: {
        "cid": id,
        "page_size": pageSize,
      },
    );
    KnowledgeDetailData data = KnowledgeDetailData.fromJson(res.data);
    return data;
  }
}
