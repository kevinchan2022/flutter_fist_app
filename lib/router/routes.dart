import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/web/webview_widget.dart';
import 'package:flutter_project/pages/auth/register_page.dart';
import 'package:flutter_project/pages/knowledge/detail/knowledge_detail_page.dart';
import 'package:flutter_project/pages/layout/layout_page.dart';
import 'package:flutter_project/pages/auth/login_page.dart';
import 'package:flutter_project/pages/search/search_page.dart';
import 'package:flutter_project/pages/web/webview_page.dart';

/// 路由地址
class RoutePath {
  // 登录页
  static const String login = '/login';
  // 注册
  static const String register = '/register';
  // 首页
  static const String layout = "/";
  // 网页页面
  static const String webviewPage = "/webview_page";
  // 知识体系明细页面
  static const String knowledgeDetailPage = '/knowledge_detail';
  // 热点搜索页
  static const String hotKeySearchPage = '/hot_key_search';
}

// ignore: avoid_classes_with_only_static_members
class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.layout:
        return pageRoute(const LayoutPage(), settings: settings);
      case RoutePath.login:
        return pageRoute(const LoginPage(), settings: settings);
      case RoutePath.register:
        return pageRoute(const RegisterPage(), settings: settings);
      case RoutePath.knowledgeDetailPage:
        return pageRoute(const KnowledgeDetailPage(), settings: settings);
      case RoutePath.webviewPage:
        return pageRoute(
            const WebviewPage(
              loadResource: "",
              webViewType: WebViewType.URL,
            ),
            settings: settings);
      case RoutePath.hotKeySearchPage:
        return pageRoute(const SearchPage(), settings: settings);
    }
    // 页面匹配失败
    return pageRoute(
      Scaffold(
        body: SafeArea(
          child: Center(
            child: Text("路由：${settings.name} 不存在"),
          ),
        ),
      ),
    );
  }

  static MaterialPageRoute pageRoute(
    Widget page, {
    RouteSettings? settings,
    bool? maintainState,
    bool? fullscreenDialog,
    bool? allowSnapshotting,
    bool? barrierDismissible,
  }) {
    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
      maintainState: maintainState ?? true,
      fullscreenDialog: fullscreenDialog ?? false,
      allowSnapshotting: allowSnapshotting ?? true,
      barrierDismissible: barrierDismissible ?? false,
    );
  }
}
