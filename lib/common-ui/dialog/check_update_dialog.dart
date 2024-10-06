import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/dialog/dialog_factory.dart';
import 'package:flutter_project/common-ui/dialog/parent_dialog.dart';

/// 检查版本更新弹窗
Future showNeedUpdateDialog({
  required BuildContext context,
  GestureTapCallback? dismissClick,
  GestureTapCallback? confirmClick,
}) async {
  DialogFactory instance = DialogFactory.instance;
  instance.showParentDialog(
    context: context,
    touchOutsideDismiss: false,
    child: CommonDialog(
      title: '检测到新版本，是否下载更新？',
      dialogContentType: DialogContentType.Normal,
      dialogButtonType: DialogButtonType.DoubleButton,
      leftOnTap: () {
        Navigator.pop(context);
        dismissClick?.call();
      },
      rightOnTap: () {
        Navigator.pop(context);
        confirmClick?.call();
      },
    ),
  );
}
