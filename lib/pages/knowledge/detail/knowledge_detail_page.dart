import 'package:flutter/material.dart';
import 'package:flutter_project/models/knowledge_data.dart';
import 'package:flutter_project/pages/knowledge/detail/knowledge_detail_view_model.dart';
import 'package:flutter_project/pages/knowledge/detail/knowledge_tab_child_page.dart';
import 'package:provider/provider.dart';

class KnowledgeDetailPage extends StatefulWidget {
  final List<KnowledgeChildren>? tabList;
  const KnowledgeDetailPage({super.key, this.tabList});

  @override
  State<KnowledgeDetailPage> createState() => _KnowledgeDetailPageState();
}

class _KnowledgeDetailPageState extends State<KnowledgeDetailPage>
    with SingleTickerProviderStateMixin {
  KnowledgeDetailViewModel viewModel = KnowledgeDetailViewModel();

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    viewModel.intTabs(widget.tabList);
    _tabController =
        TabController(length: widget.tabList?.length ?? 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            // 去除第一个的左边距
            tabAlignment: TabAlignment.start,
            // 去除下边线
            dividerHeight: 0,
            tabs: viewModel.tabs,
            controller: _tabController,
            // 选中颜色
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            // 可滑动
            isScrollable: true,
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: childPages(),
          ),
        ),
      ),
    );
  }

  List<Widget> childPages() {
    return widget.tabList
            ?.map((e) => KnowledgeTabChildPage(id: e.id ?? 0))
            .toList() ??
        [];
  }
}
