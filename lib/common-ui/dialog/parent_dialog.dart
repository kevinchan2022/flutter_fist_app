import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum DialogContentType { Normal, RichText, NormalNoTitle, RichTextNoTitle }

enum DialogButtonType {
  DoubleButton,
  SingleTextButton,
  SingleRadiusButton,
  DoubleRadiusButton,
  Cumstom
}

/// 通用弹窗父组件
class ParentDialog extends Dialog {
  // 是否点击空白消失
  final bool? touchOutsideDismiss;

  // 弹窗外部区域背景色
  final Color? outsideBackgroundColor;

  // 弹窗圆角
  final double? borderRadius;

  // 宽度
  final double? width;

  // 高度
  final double? height;

  // 外边距
  final EdgeInsetsGeometry? margin;

  // 内边距
  final EdgeInsetsGeometry? padding;

  // 弹窗外部区域点击事件
  final GestureTapCallback? outsideOnTap;

  // 弹窗子组件布局
  final Widget childWidget;

  // 底部透明消失按钮事件
  final GestureTapCallback? dismissClick;

  // 是否显示底部透明消失按钮
  final bool? showTransparentButton;

  // 是否点击空白区域关闭软键盘
  final bool? touchOutsideCloseKeyboard;

  // 子布局背景色
  final Color? bodyBackgroudColor;

  const ParentDialog({
    required this.childWidget,
    this.touchOutsideDismiss,
    this.outsideBackgroundColor,
    this.borderRadius,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.outsideOnTap,
    this.dismissClick,
    this.showTransparentButton,
    this.touchOutsideCloseKeyboard,
    this.bodyBackgroudColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: outsideBackgroundColor ?? Colors.black,
      body: PopScope(
        canPop: touchOutsideDismiss ?? false,
        onPopInvokedWithResult: (bool didPop, result) {
          if (didPop) return;
          // 隐藏软键盘
          if (touchOutsideCloseKeyboard == true) {
            FocusScope.of(context).unfocus();
          }
        },
        child: GestureDetector(
          onTap: () {
            // 隐藏软键盘
            if (touchOutsideCloseKeyboard == true) {
              FocusScope.of(context).unfocus();
            }
            if (touchOutsideDismiss == true) {
              Navigator.pop(context);
            }
            if (outsideOnTap != null) {
              outsideOnTap?.call();
            }
          },
          child: Center(
            child: _showDialogBody(context),
          ),
        ),
      ),
    );
  }

  Widget _showDialogBody(BuildContext context) {
    if (showTransparentButton == true) {
      return ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          _dialogBody(context),
          SizedBox(height: 20.h),
          _dismissButtonWidget(context),
        ],
      );
    } else {
      return _dialogBody(context);
    }
  }

  Widget _dialogBody(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 37.w),
      padding: padding ?? EdgeInsets.zero,
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius ?? 10.r),
        ),
        color: bodyBackgroudColor ?? Theme.of(context).listTileTheme.tileColor,
      ),
      child: IntrinsicHeight(child: childWidget),
    );
  }

  Widget _dismissButtonWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          if (dismissClick != null && showTransparentButton == true) {
            dismissClick?.call();
          }
        },
        child: FlutterLogo(size: 45.r),
      ),
    );
  }
}

class CommonDialog extends StatelessWidget {
  // 内容样式
  final DialogContentType dialogContentType;

  // 按钮样式
  final DialogButtonType dialogButtonType;

  // 标题
  final String? title;

  // 标题样式
  final String? titleStyle;

  // 标题内容
  final String? content;

  // 自定义内容
  final Widget? customContentWidget;

  // 标题下内容样式
  final TextStyle? contentStyle;

  // 标题与内容宽度
  final double? contentHeight;

  // 标题与内容高度
  final double? contentWidth;

  // 富文本内容
  final List<InlineSpan>? richChildren;

  // 标题与内容内边距
  final EdgeInsetsGeometry? contentPadding;

  // 标题与内容外边距
  final EdgeInsetsGeometry? contentMargin;

  // 左边按钮文本
  final String? leftButtonText;

  // 右边按钮文本
  final String? rightButtonText;

  // 左边按钮事件
  final GestureTapCallback? leftOnTap;

  // 右边按钮事件
  final GestureTapCallback? rightOnTap;

  // 按钮区域高度
  final double? buttonAreaHeight;

  // 左边按钮文本样式
  final TextStyle? leftTextStyle;

  // 右边按钮文本样式
  final TextStyle? rightTextStyle;

  // 单按钮文本
  final String? singleButtonText;

  // 单按钮事件
  final GestureTapCallback? singleButtonOnTap;

  // 单按钮文本样式
  final TextStyle? singleButtonTextStyle;

  // 单个圆角按钮自定义样式
  final Widget? singleRadiusButton;

  // 自定义底部按钮布局：自定义底部布局不为空时内置按钮组件会失效，自定义优先级高
  final Widget? customBottomButtonWidget;

  // 背景颜色
  final Color? backgroundColor;

  // 圆角
  final BorderRadius? borderRadius;

  const CommonDialog({
    super.key,
    required this.dialogContentType,
    required this.dialogButtonType,
    this.title,
    this.titleStyle,
    this.content,
    this.customContentWidget,
    this.contentStyle,
    this.contentHeight,
    this.contentWidth,
    this.richChildren,
    this.contentPadding,
    this.contentMargin,
    this.leftButtonText,
    this.rightButtonText,
    this.leftOnTap,
    this.rightOnTap,
    this.buttonAreaHeight,
    this.leftTextStyle,
    this.rightTextStyle,
    this.singleButtonText,
    this.singleButtonOnTap,
    this.singleButtonTextStyle,
    this.singleRadiusButton,
    this.customBottomButtonWidget,
    this.backgroundColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
