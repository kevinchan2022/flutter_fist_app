import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/loading.dart';
import 'package:flutter_project/models/knowledge_data.dart';
import 'package:flutter_project/pages/knowledge/detail/knowledge_detail_page.dart';
import 'package:flutter_project/pages/knowledge/knowledge_vm.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  KnowledgeVM viewModel = KnowledgeVM();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        // 初始化数据
        _initData();
      },
    );
  }

  Future _initData() async {
    Loading.showLoading();
    await viewModel.getKnowledge();
    Loading.dismissAll();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SafeArea(
          child: Consumer<KnowledgeVM>(
            builder: (context, vm, child) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return _itemView(vm.knowledgeList?[index]);
                },
                itemCount: vm.knowledgeList?.length ?? 0,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _itemView(KnowledgeData? item) {
    void onTap() {
      // 进入明细页面
      RouteUtils.push(
        context,
        KnowledgeDetailPage(
          tabList: item?.children,
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(5.r),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.name ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    viewModel.handleSubTitle(item?.children),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              "assets/images/arrow-right.png",
              width: 15.w,
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
