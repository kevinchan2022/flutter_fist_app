import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/common_text_style.dart';
import 'package:flutter_project/common-ui/web/webview_widget.dart';
import 'package:flutter_project/models/knowledge_detail_data.dart';
import 'package:flutter_project/pages/knowledge/detail/knowledge_detail_view_model.dart';
import 'package:flutter_project/pages/web/webview_page.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class KnowledgeTabChildPage extends StatefulWidget {
  const KnowledgeTabChildPage({super.key, required this.id});

  final int id;

  @override
  State<KnowledgeTabChildPage> createState() => _KnowledgeTabChildPageState();
}

class _KnowledgeTabChildPageState extends State<KnowledgeTabChildPage> {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    // 初始化数据
    viewModel.initDetailData(widget.id);
  }

  void _onRefresh() async {
    await viewModel.initDetailData(widget.id);
    _refreshController.refreshCompleted();
    // 重置没有更多
    _refreshController.resetNoData();
  }

  void _onLoading() async {
    bool canLoad = await viewModel.loadMore(widget.id);
    if (canLoad == true) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: Consumer<KnowledgeDetailViewModel>(
          builder: (context, vm, child) {
            return SmartRefresher(
              controller: _refreshController,
              enablePullUp: true,
              enablePullDown: true,
              header: const ClassicHeader(),
              footer: const ClassicFooter(),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemCount: vm.detailItemList.length,
                itemBuilder: (context, index) {
                  var item = vm.detailItemList[index];
                  return _itemText(item, onTap: () {
                    // 跳转网页
                    RouteUtils.push(
                      context,
                      WebviewPage(
                        webViewType: WebViewType.URL,
                        loadResource: item.link ?? '',
                        showTitle: true,
                        title: item.title,
                      ),
                    );
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _itemText(KnowledgeDetailItem? item, {GestureCancelCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12, width: 0.5.r),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(item?.superChapterName ?? '', style: titleTextStyle15),
                const Expanded(child: SizedBox()),
                Text(item?.niceShareDate ?? ''),
              ],
            ),
            Text(item?.title ?? '', style: titleTextStyle15),
            Row(
              children: [
                Text(item?.chapterName ?? ''),
                const Expanded(child: SizedBox()),
                Text(item?.shareUser ?? ''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
