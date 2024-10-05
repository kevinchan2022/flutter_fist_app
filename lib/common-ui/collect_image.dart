import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget collectImage(bool? isCollect, {GestureTapCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset(
      isCollect == true
          ? "assets/images/collect_fill.png"
          : "assets/images/collect_grey.png",
      width: 25.r,
      height: 25.r,
    ),
  );
}
