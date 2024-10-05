import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonLargeButton extends StatelessWidget {
  const CommonLargeButton({super.key, required this.title, this.onTap});

  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return // 登录按钮
        GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 45.h,
        margin: EdgeInsets.symmetric(horizontal: 40.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(22.5.r)),
          border: Border.all(color: Colors.white, width: 1.r),
        ),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ),
    );
  }
}
