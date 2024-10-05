import 'package:flutter/material.dart';

/// 路由管理工具类
class RouteUtils {
  RouteUtils._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  // APP 根节点state
  static BuildContext get context => navigatorKey.currentContext!;

  static NavigatorState get navigator => navigatorKey.currentState!;

  // 普通动态跳转
  static Future push(
    BuildContext context,
    Widget page, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool maintainState = true,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
        fullscreenDialog: fullscreenDialog ?? false,
        settings: settings,
        maintainState: maintainState,
      ),
    );
  }

  // 根据路由路径跳转
  static Future pushNamed(
    BuildContext context,
    String name, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(context, name, arguments: arguments);
  }

  // 自定义route动态跳转
  static Future pushForPageRoute(BuildContext context, Route route) {
    return Navigator.push(context, route);
  }

  // 清空栈，只留目标页面
  static Future pushNamedAndRemoveUtil(
      BuildContext context, String name, Object? arguments) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      name,
      (route) => false,
      arguments: arguments,
    );
  }

  // 清空栈，只留目标页面
  static Future pushAndRemoveUtil(
    BuildContext context,
    Widget page, {
    bool? fullscreenDialog,
    RouteSettings? settings,
    bool maintainState = true,
  }) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => page,
        fullscreenDialog: fullscreenDialog ?? false,
        settings: settings,
        maintainState: maintainState,
      ),
      (route) => false,
    );
  }

  // 用新的路由替换当前路由
  static Future pushReplacementNamed(
    BuildContext context,
    String name, {
    Object? result,
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      name,
      arguments: arguments,
      result: result,
    );
  }

  // 关闭当前页面
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  // 关闭当前页面包含返回值
  static void popOfData<T extends Object?>(
    BuildContext context, {
    T? data,
  }) {
    Navigator.of(context).pop(data);
  }
}
