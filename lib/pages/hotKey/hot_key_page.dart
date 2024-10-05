import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/web/webview_widget.dart';
import 'package:flutter_project/models/hot_keys_data.dart';
import 'package:flutter_project/models/websites_data.dart';
import 'package:flutter_project/pages/hotKey/hot_key_vm.dart';
import 'package:flutter_project/pages/search/search_page.dart';
import 'package:flutter_project/pages/web/webview_page.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HotKeyPage extends StatefulWidget {
  const HotKeyPage({super.key});

  @override
  State<HotKeyPage> createState() => _HotKeyPageState();
}

// 常用网站tap回调
typedef WebsiteClick = Function(String name, String link);

class _HotKeyPageState extends State<HotKeyPage> {
  HotKeyVM viewModel = HotKeyVM();

  @override
  void initState() {
    super.initState();
    viewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 45.h,
                  // 分割线
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5.r, color: Colors.grey),
                      bottom: BorderSide(width: 0.5.r, color: Colors.grey),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Row(
                    children: [
                      Text(
                        '搜索热词',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      GestureDetector(
                        onTap: () =>
                            RouteUtils.push(context, const SearchPage()),
                        child: Icon(Icons.search, size: 30.r),
                      ),
                    ],
                  ),
                ),

                // 搜索热词列表
                Consumer<HotKeyVM>(
                  builder: (context, vm, child) {
                    void tabChange(String value) {
                      RouteUtils.push(context, SearchPage(keyword: value));
                    }

                    return _gridView(
                      false,
                      hotKeyList: vm.hotKeyList,
                      itemTap: tabChange,
                    );
                  },
                ),

                // 常用网站标题
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  height: 45.h,
                  alignment: Alignment.centerLeft,
                  // 分割线
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 0.5.r, color: Colors.grey),
                      bottom: BorderSide(width: 0.5.r, color: Colors.grey),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Text(
                    '常用网站',
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                  ),
                ),
                // 常用网站列表
                Consumer<HotKeyVM>(
                  builder: (context, vm, child) {
                    void handleWebsiteClick(String name, String link) {
                      RouteUtils.push(
                        context,
                        WebviewPage(
                          loadResource: link,
                          webViewType: WebViewType.URL,
                          showTitle: true,
                          title: name,
                        ),
                      );
                    }

                    return _gridView(true,
                        websitList: vm.websitesList,
                        websiteClick: handleWebsiteClick);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _gridView(
    bool isWebsite, {
    List<WebsitesData>? websitList,
    List<HotKeysData>? hotKeyList,
    ValueChanged<String>? itemTap,
    WebsiteClick? websiteClick,
  }) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true, // 动态计算高度
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          // 主轴间隔
          mainAxisSpacing: 8.r,
          // 最大横轴范围
          maxCrossAxisExtent: 120.w,
          // 宽高比
          childAspectRatio: 3,
          // 横轴间隔
          crossAxisSpacing: 8.r,
        ),
        itemBuilder: (context, index) {
          if (isWebsite) {
            return _gridItem(
              name: websitList?[index].name,
              websiteClick: websiteClick,
              link: websitList?[index].link,
            );
          } else {
            return _gridItem(name: hotKeyList?[index].name, itemTap: itemTap);
          }
        },
        itemCount: isWebsite == true
            ? websitList?.length ?? 0
            : hotKeyList?.length ?? 0,
      ),
    );
  }

  Widget _gridItem({
    String? name,
    ValueChanged<String>? itemTap,
    WebsiteClick? websiteClick,
    String? link,
  }) {
    return GestureDetector(
      onTap: () {
        if (link != null) {
          websiteClick?.call(name ?? '', link);
        } else {
          itemTap?.call(name ?? "");
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5.r),
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: Text(name ?? ""),
      ),
    );
  }
}
