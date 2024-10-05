import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class Loading {
  // 设置私有构造方法，禁止初始化
  Loading._();

  static Future showLoading({Duration? duration}) async {
    showToastWidget(
      Container(
        color: Colors.transparent,
        // 占满全屏
        constraints: const BoxConstraints.expand(),
        child: Align(
          child: Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: Colors.black54,
            ),
            child: CircularProgressIndicator(
              strokeWidth: 2.w,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
      ),
      // 不调用dismiss一直转
      duration: duration ?? const Duration(days: 1),
      // 点击空白不能消失
      handleTouch: true,
    );
  }

  static void dismissAll() {
    dismissAllToast();
  }
}
