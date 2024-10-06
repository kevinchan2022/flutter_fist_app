import 'package:flutter/material.dart';
import 'package:flutter_project/pages/about_us/about_us_page.dart';
import 'package:flutter_project/pages/auth/login_page.dart';
import 'package:flutter_project/pages/collects/collects_page.dart';
import 'package:flutter_project/pages/my/my_view_model.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                _settingsItem('我的收藏', () {
                  RouteUtils.push(context, const CollectsPage());
                }),
                _settingsItem('检查更新', () => {}),
                _settingsItem('关于我们', () {
                  RouteUtils.push(context, const AboutUsPage());
                }),
                Consumer<MyViewModel>(
                  builder: (context, vm, child) {
                    if (vm.needLogin) {
                      return const SizedBox();
                    }
                    return _settingsItem('退出登录', doLogout);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  Widget _settingsItem(String? title, GestureTapCallback? onTap) {
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? "",
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
            ),
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
}
