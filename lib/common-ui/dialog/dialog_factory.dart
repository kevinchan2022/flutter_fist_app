import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/dialog/parent_dialog.dart';

/// 通用弹窗工具类
class DialogFactory {
  static DialogFactory instance = DialogFactory();

  Future showParentDialog({
    required BuildContext context,
    required Widget child,
    bool? touchOutsideDismiss,
    Color? outsideBackgroundColor,
    double? borderRadius,
    double? width,
    double? height,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    GestureTapCallback? outsideOnTap,
    GestureTapCallback? dismissClick,
    bool? showTransparentButton,
    bool? touchOutsideCloseKeyboard,
    Color? bodyBackgroudColor,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return ParentDialog(
          bodyBackgroudColor: bodyBackgroudColor,
          touchOutsideDismiss: touchOutsideDismiss,
          touchOutsideCloseKeyboard: touchOutsideCloseKeyboard,
          outsideBackgroundColor: outsideBackgroundColor,
          borderRadius: borderRadius,
          width: width,
          height: height,
          margin: margin,
          padding: padding,
          outsideOnTap: outsideOnTap,
          childWidget: child,
          dismissClick: dismissClick,
          showTransparentButton: showTransparentButton,
        );
      },
    );
  }
}
