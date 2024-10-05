import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/active_animation_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigatorWidget extends StatefulWidget {
  BottomNavigatorWidget({
    super.key,
    required this.pages,
    required this.labels,
    required this.icons,
    required this.activeIcons,
    this.currentIndex,
    this.onTabChange,
  }) {
    // 保证传入的pages和icons的长度一致
    if (!(pages.length == labels.length &&
        pages.length == icons.length &&
        pages.length == activeIcons.length)) {
      throw Exception("页面数量必须和label及icon的数组长度一致");
    }
  }

  // 页面列表
  final List<Widget> pages;
  // final List<Widget Function(BuildContext)> pages;

  // 底部labels
  final List<String> labels;

  // 未激活icons
  final List<Widget> icons;

  // 激活icons
  final List<Widget> activeIcons;

  final int? currentIndex;

  final ValueChanged<int>? onTabChange;

  @override
  State<BottomNavigatorWidget> createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  int? _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex ?? 0,
          children: widget.pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex ?? 0,
        selectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          color: Colors.blueGrey,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          color: Colors.grey,
        ),
        items: _barItemList(),
        onTap: (index) {
          _currentIndex = index;
          // 调用tagChange事件
          widget.onTabChange?.call(index);
          // 刷新
          setState(() {});
        },
      ),
    );
  }

  List<BottomNavigationBarItem> _barItemList() {
    List<BottomNavigationBarItem> items = [];
    for (int i = 0; i < widget.pages.length; i++) {
      items.add(
        BottomNavigationBarItem(
          label: widget.labels[i],
          icon: widget.icons[i],
          activeIcon: ActiveAnimationWidget(
            builder: (context) {
              return widget.activeIcons[i];
            },
          ),
        ),
      );
    }
    return items;
  }
}
