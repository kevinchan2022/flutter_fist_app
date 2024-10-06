import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/dialog/check_update_dialog.dart';
import 'package:flutter_project/pages/about_us/about_us_page.dart';
import 'package:flutter_project/pages/auth/login_page.dart';
import 'package:flutter_project/pages/collects/collects_page.dart';
import 'package:flutter_project/pages/my/my_view_model.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  MyViewModel viewModel = MyViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.initData();
  }

  @override
  Widget build(BuildContext context) {
    void headerClik() {
      if (viewModel.needLogin == true) {
        RouteUtils.push(context, const LoginPage());
      }
    }

    Future doLogout() async {
      bool isSuccess = await viewModel.logout();
      if (isSuccess == true) {
        // 清空路由栈, 并跳转登录页
        RouteUtils.pushAndRemoveUtil(context, const LoginPage());
      }
    }

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                _header(headerClik),
                _settingsItem(
                    title: '我的收藏',
                    onTap: () {
                      RouteUtils.push(context, const CollectsPage());
                    }),
                Consumer<MyViewModel>(builder: (context, vm, child) {
                  return _settingsItem(
                      title: '检查更新',
                      showDot: vm.showDot,
                      onTap: () {
                        checkAppUpdate();
                      });
                }),
                _settingsItem(
                    title: '关于我们',
                    onTap: () {
                      RouteUtils.push(context, const AboutUsPage());
                    }),
                Consumer<MyViewModel>(
                  builder: (context, vm, child) {
                    if (vm.needLogin) {
                      return const SizedBox();
                    }
                    return _settingsItem(title: '退出登录', onTap: doLogout);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 检查更新
  void checkAppUpdate() async {
    String? url = await viewModel.checkUpdate();
    if (url != null && url.isNotEmpty == true) {
      // showNeedUpdateDialog(
      //   context: context,
      //   dismissClick: () {
      //     // 是否显示红点
      //     viewModel.shouldShowUpdateDot();
      //   },
      //   confirmClick: () {
      //     // 跳转到外部浏览器打开
      //     viewModel.jumpToOutLink(url);
      //   },
      // );
      viewModel.shouldShowUpdateDot();
    } else {
      showToast('已经是最新版本');
    }
  }

  Widget _header(GestureTapCallback? onTap) {
    return Container(
      // 居中
      alignment: Alignment.center,
      color: Colors.teal,
      width: double.infinity,
      height: 200,
      child: Column(
        // 主轴
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(35.r)),
              child: Image.asset(
                'assets/images/logo.png',
                width: 70.r,
                height: 70,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: 6.h),
          Consumer<MyViewModel>(
            builder: (context, vm, child) => GestureDetector(
              onTap: onTap,
              child: Text(
                vm.username ?? "",
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _settingsItem(
      {String? title, bool? showDot, GestureTapCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45.h,
        margin: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0.5.r),
          borderRadius: BorderRadius.all(Radius.circular(5.r)),
        ),
        child: Row(
          // 左右布局
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            showDot == true ? _redDot() : const SizedBox(),
            Text(
              title ?? "",
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
            const Expanded(child: SizedBox()),
            Image.asset(
              "assets/images/arrow-right.png",
              width: 14.r,
              height: 14.r,
            )
          ],
        ),
      ),
    );
  }

  Widget _redDot() {
    return Container(
      margin: EdgeInsets.only(right: 2.w),
      width: 5.w,
      height: 5.h,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(2.5)),
        color: Colors.red,
      ),
    );
  }
}
