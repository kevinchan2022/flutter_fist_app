import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_project/common-ui/web/webview_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebviewPage extends StatefulWidget {
  // 是否显示标题
  final bool? showTitle;
  // 标题内容
  final String? title;
  // 需要加载的内容类型
  final WebViewType webViewType;
  // 加载的数据: url/html文本
  final String loadResource;
  // 与js通信的chanel集合
  final Map<String, JavaScriptHandlerCallback>? jsChannelMap;

  const WebviewPage({
    super.key,
    required this.webViewType,
    required this.loadResource,
    this.title,
    this.showTitle,
    this.jsChannelMap,
  });

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late String? _title;
  late bool? _showTitle;

  @override
  void initState() {
    super.initState();
    _title = widget.title ?? '';
    _showTitle = widget.showTitle ?? false;

    // 组件初始化完成后执行回调
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (timeStamp) {
    //     // 获取路由参数
    //     final params = ModalRoute.of(context)?.settings.arguments;
    //     if (params is Map) {
    //       final name = params["name"] as String;
    //       _title = name;
    //       setState(() {});
    //     }
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _showTitle == true
          ? AppBar(title: _buildAppBarTitle(_showTitle, _title))
          : null,
      body: SafeArea(
        child: WebviewWidget(
          webViewType: widget.webViewType,
          loadResource: widget.loadResource,
          jsChannelMap: widget.jsChannelMap,
        ),
      ),
    );
  }

  Widget _buildAppBarTitle(bool? showTitle, String? title) {
    bool show = showTitle ?? false;
    return show
        ? Html(
            data: title ?? '',
            style: {
              'html': Style(fontSize: FontSize(15.sp)),
            },
          )
        : const SizedBox.shrink();
  }

  String limitStr(String? content, {int limit = 15}) {
    if (content == null || content.isEmpty == true) {
      return '';
    }
    return content.length > limit ? content.substring(0, limit) : content;
  }
}
