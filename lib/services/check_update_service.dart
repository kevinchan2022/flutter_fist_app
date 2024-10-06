import 'package:flutter_project/constants/http_config.dart';
import 'package:flutter_project/utils/http/http_util.dart';

class CheckUpdateService {
  static final CheckUpdateService _instance = CheckUpdateService._();

  factory CheckUpdateService() => _instance;

  CheckUpdateService._();

  final HttpUtil _httpUtil = HttpUtil();

  Future checkUpdate() async {
    // 改变baseUrl
    _httpUtil.changeBaseUrl(HttpConfig.CHECK_UPDATE_BASE_URL);
    final res = await _httpUtil.post(
      path: "apiv2/app/check",
      queryParameters: {"_api_key": "", "appKey": ""},
    );
    // 还原baseUrl
    _httpUtil.changeBaseUrl(HttpConfig.BASE_URL);
    return res.data;
  }
}
