import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_project/common-ui/loading.dart';

// 需要加载的内容类型
enum WebViewType { HTMLTEXT, URL }

class WebviewWidget extends StatefulWidget {
  const WebviewWidget({
    super.key,
    required this.webViewType,
    required this.loadResource,
    this.clearCache,
    this.jsChannelMap,
    this.onWebviewCreated,
  });

  // 加载的内容类型
  final WebViewType webViewType;
  // 给webview加载的数据：url/html文本
  final String loadResource;
  // 是否清除缓存后再加载
  final bool? clearCache;
  // 与js通信的channel集合
  final Map<String, JavaScriptHandlerCallback>? jsChannelMap;

  final Function(InAppWebViewController controller)? onWebviewCreated;

  @override
  State<WebviewWidget> createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  // webview控制器
  late InAppWebViewController webViewController;

  late PlatformInAppWebViewController platform;

  final GlobalKey webviewKey = GlobalKey();

  // webview配置
  InAppWebViewSettings settings = InAppWebViewSettings(
    // 跨平台配置
    // useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    // 安卓平台配置
    builtInZoomControls: false,
    useHybridComposition: true,
    // ios平台配置
    allowsInlineMediaPlayback: true,
  );
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      key: webviewKey,
      initialSettings: settings,
      onWebViewCreated: (controller) {
        // webview初始化完成之后加载数据
        webViewController = controller;
        if (widget.clearCache == true) {
          webViewController.platform.clearAllCache();
        }

        // 向外抛出created回调，外部可进行控制
        if (widget.onWebviewCreated == null) {
          if (widget.webViewType == WebViewType.HTMLTEXT) {
            webViewController.loadData(data: widget.loadResource);
          } else if (widget.webViewType == WebViewType.URL) {
            log('url:${widget.loadResource}');
            webViewController.loadUrl(
              urlRequest: URLRequest(
                url: WebUri.uri(Uri.parse(widget.loadResource)),
              ),
            );
          }
        } else {
          widget.onWebviewCreated?.call(controller);
        }

        // 注册JS通信回调
        widget.jsChannelMap?.forEach((handlerName, callback) {
          webViewController.addJavaScriptHandler(
              handlerName: handlerName, callback: callback);
        });
      },
      onConsoleMessage: (controller, consoleMessage) {
        // 打印js日志
        log("console.log:$consoleMessage}");
      },
      onLoadStart: (controller, url) {
        Loading.showLoading(duration: const Duration(seconds: 30));
      },
      onReceivedError: (controller, request, error) {
        Loading.dismissAll();
      },
      onLoadStop: (controller, url) {
        Loading.dismissAll();
      },
    );
  }
}
