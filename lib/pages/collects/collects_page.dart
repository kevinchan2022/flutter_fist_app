import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/collect_image.dart';
import 'package:flutter_project/common-ui/common_text_style.dart';
import 'package:flutter_project/common-ui/loading.dart';
import 'package:flutter_project/common-ui/web/webview_widget.dart';
import 'package:flutter_project/models/collects_data.dart';
import 'package:flutter_project/pages/collects/collects_view_model.dart';
import 'package:flutter_project/pages/web/webview_page.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollectsPage extends StatefulWidget {
  const CollectsPage({super.key});

  @override
  State<CollectsPage> createState() => _CollectsPageState();
}

class _CollectsPageState extends State<CollectsPage> {
  CollectsViewModel viewModel = CollectsViewModel();

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _initData();
    }
  }

  Future _initData() async {
    Loading.showLoading();
    await viewModel.initCollectData();
    Loading.dismissAll();
  }

  // 下拉刷新
  void _onRefresh() async {
    await _initData();
    _refreshController.refreshCompleted();
    // 重置没有更多
    _refreshController.resetNoData();
  }

  // 上拉加载
  void _onLoading() async {
    Loading.showLoading();
    bool canLoad = await viewModel.loadMoreData();
    Loading.dismissAll();
    if (canLoad) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('我的收藏'),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(child: Consumer<CollectsViewModel>(
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
                  itemBuilder: (context, index) {
                    return _collectItem(
                      vm.collectsList[index],
                      // 取消收藏
                      onTap: () =>
                          vm.cancelCollect(index, vm.collectsList[index].id),
                      // 进入网页
                      itemClick: () => RouteUtils.push(
                        context,
                        WebviewPage(
                          webViewType: WebViewType.URL,
                          loadResource: vm.collectsList[index].link ?? '',
                          showTitle: true,
                          title: vm.collectsList[index].title,
                        ),
                      ),
                    );
                  },
                  itemCount: vm.collectsList.length,
                ),
              );
            },
          ))),
    );
  }

  Widget _collectItem(CollectsItemData item,
      {GestureTapCallback? onTap, GestureTapCallback? itemClick}) {
    return GestureDetector(
      onTap: itemClick,
      child: Container(
        margin: EdgeInsets.all(10.r),
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text('作者:${item.author}')),
                Text('时间:${item.niceDate}'),
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            Text('${item.title}', style: titleTextStyle15),
            Row(
              children: [
                Expanded(child: Text('分类:${item.chapterName}')),
                collectImage(true, onTap: onTap),
              ],
            )
          ],
        ),
      ),
    );
  }
}
