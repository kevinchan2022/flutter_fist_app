import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/bottom_navigator_widget.dart';
import 'package:flutter_project/pages/home/home_page.dart';
import 'package:flutter_project/pages/hotKey/hot_key_page.dart';
import 'package:flutter_project/pages/knowledge/knowledge_page.dart';
import 'package:flutter_project/pages/my/my_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  // 页面列表
  late List<Widget> pages;
  // 懒加载
  // late List<Widget Function(BuildContext)> pages;

  // 底部labels
  late List<String> labels;

  // 未激活icons
  late List<Widget> icons;

  // 激活icons
  late List<Widget> activeIcons;

  void initTabData() {
    pages = [
      const HomePage(),
      const HotKeyPage(),
      const KnowledgePage(),
      const MyPage()
    ];
    // pages = [
    //   (context) => const HomePage(),
    //   (context) => const HotKeyPage(),
    //   (context) => const KnowledgePage(),
    //   (context) => const MyPage()
    // ];
    labels = ["首页", "热点", "体系", "我的"];
    icons = [
      Icon(
        Icons.home,
        size: 32.r,
        color: Colors.grey,
      ),
      Icon(
        Icons.radar,
        size: 32.r,
        color: Colors.grey,
      ),
      Icon(
        Icons.book,
        size: 32.r,
        color: Colors.grey,
      ),
      Icon(
        Icons.person,
        size: 32.r,
        color: Colors.grey,
      ),
    ];
    activeIcons = [
      Icon(
        Icons.home,
        size: 32.r,
        color: Colors.blueGrey,
      ),
      Icon(
        Icons.radar,
        size: 32.r,
        color: Colors.blueGrey,
      ),
      Icon(
        Icons.book,
        size: 32.r,
        color: Colors.blueGrey,
      ),
      Icon(
        Icons.person,
        size: 32.r,
        color: Colors.blueGrey,
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    initTabData();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigatorWidget(
      pages: pages,
      labels: labels,
      icons: icons,
      activeIcons: activeIcons,
      currentIndex: 0,
    );
  }
}
