import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/collect_image.dart';
import 'package:flutter_project/common-ui/loading.dart';
import 'package:flutter_project/common-ui/web/webview_widget.dart';
import 'package:flutter_project/models/home_list_data.dart';
import 'package:flutter_project/pages/home/home_view_model.dart';
import 'package:flutter_project/pages/web/webview_page.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeViewModel viewModel = HomeViewModel();

  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    // 组件初始化完成后执行回调
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _initData();
      },
    );
  }

  Future _initData() async {
    Loading.showLoading();
    Future f1 = viewModel.getBanner();
    Future f2 = viewModel.initListData();
    await Future.wait([f1, f2]);
    Loading.dismissAll();
  }

  void _onRefresh() async {
    await _initData();
    _refreshController.refreshCompleted();
    // 重置没有更多
    _refreshController.resetNoData();
  }

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
        body: SafeArea(
            child:
                // Column(
                //   children: [
                //     _banner(),
                //     Expanded(
                //       child: ListView.builder(
                //         itemBuilder: (context, index) => _listView(),
                //         itemCount: 100,
                //       ),
                //     ),
                //   ],
                // ),
                // 实现bannber和listView的一起滚动
                SmartRefresher(
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: true,
          header: const ClassicHeader(),
          footer: const ClassicFooter(),
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _banner(),
                _homeListView(),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _banner() {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) => SizedBox(
        height: 150.h,
        width: double.infinity,
        child: Swiper(
          itemCount: vm.bannerList?.length ?? 0,
          pagination: const SwiperPagination(),
          control: const SwiperControl(),
          itemBuilder: (context, index) {
            var item = vm.bannerList?[index];
            return GestureDetector(
              onTap: () {
                // 跳转网页
                RouteUtils.push(
                  context,
                  WebviewPage(
                    webViewType: WebViewType.URL,
                    loadResource: item?.url ?? '',
                    showTitle: true,
                    title: item?.title ?? '',
                  ),
                );
              },
              child: SizedBox(
                height: 150.h,
                // color: Colors.lightBlue,
                child: Image.network(
                  item?.imagePath ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _homeListView() {
    return Consumer<HomeViewModel>(
      builder: (context, vm, child) {
        return ListView.builder(
          // 计算当前全部子组件的高度
          shrinkWrap: true,
          // 禁用listView的滚动
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              _listView(vm.homeList?[index], index),
          itemCount: vm.homeList?.length ?? 0,
        );
      },
    );
  }

  Widget _listView(HomeListItem? item, int index) {
    String name;
    if (item?.author?.isNotEmpty == true) {
      name = item?.author ?? "";
    } else {
      name = item?.shareUser ?? "";
    }
    // InkWell
    // 监听点击事件
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const WebviewPage(
        //       title: 'From HomePage',
        //     ),
        //   ),
        // );
        // 跳转网页
        RouteUtils.push(
          context,
          WebviewPage(
            webViewType: WebViewType.URL,
            loadResource: item?.link ?? "",
            showTitle: true,
            title: item?.title ?? "",
          ),
        );
        // 静态路由传参
        // RouteUtils.pushNamed(
        //   context,
        //   RoutePath.webviewPage,
        //   arguments: {
        //     "name": "route params",
        //   },
        // );
        // Navigator.pushNamed(context, RoutePath.webviewPage);
      },
      child: Container(
        // margin
        // margin: EdgeInsets.all(15.r),
        margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
        // padding
        padding:
            EdgeInsets.only(top: 15.h, bottom: 15.h, left: 10.w, right: 10.w),
        // border
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 0.5.r),
            borderRadius: BorderRadius.all(Radius.circular(6.r))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // 圆角图片
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.r),
                  child: Image.network(
                    "https://via.placeholder.com/30x30",
                    // "https://img2.baidu.com/it/u=2618357109,2025398950&fm=253&fmt=auto&app=138&f=JPEG?w=190&h=190",
                    width: 30.r,
                    height: 30.r,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.yellowAccent,
                      child: const Icon(Icons.error),
                    ),
                  ),
                ),
                // 间隔
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  name,
                  style:
                      const TextStyle(color: Color.fromARGB(255, 87, 58, 58)),
                ),
                const Expanded(child: SizedBox()),
                // 间隔
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: Text(
                    item?.niceShareDate ?? "",
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                  ),
                ),
                (item?.type?.toInt() == 1)
                    ? const Text(
                        "置顶",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      )
                    : const SizedBox(),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              item?.title ?? "",
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            Row(
              children: [
                Text(
                  item?.chapterName ?? "",
                  style: TextStyle(color: Colors.green, fontSize: 12.sp),
                ),
                const Expanded(child: SizedBox()),
                // 收藏
                collectImage(
                  item?.collect,
                  onTap: () => viewModel.collectOrNot(
                    item?.collect == true ? false : true,
                    item?.id,
                    index,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
