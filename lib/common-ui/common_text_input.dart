import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextInput extends StatelessWidget {
  const CommonTextInput(
      {super.key,
      this.labelText,
      this.controller,
      this.onChanged,
      this.obscureText});

  final String? labelText;
  final TextEditingController? controller;
  final ValueChanged? onChanged;
  final bool? obscureText; // 密码样式输入

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText ?? false,
      controller: controller,
      onChanged: onChanged,
      // 光标颜色
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.5.r)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.r),
        ),
        labelText: '请输入',
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
