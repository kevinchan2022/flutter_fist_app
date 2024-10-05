import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_project/common-ui/web/webview_widget.dart';
import 'package:flutter_project/pages/search/search_view_model.dart';
import 'package:flutter_project/pages/web/webview_page.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, this.keyword});

  final String? keyword;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController textEditingController;

  SearchViewModel viewModel = SearchViewModel();

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.keyword ?? '');
    // 搜索
    viewModel.keywordSeach(widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    void onBack() => RouteUtils.pop(context);
    void onCancel() {
      textEditingController.text = '';
      viewModel.clearSearchList();
      // 隐藏软键盘
      Focus.of(context).unfocus();
    }

    void onSearch(value) {
      viewModel.keywordSeach(value);
      // 隐藏手机键盘方式1 （原生方式，调用了原生代码）
      // SystemChannels.textInput.invokeMethod("TextInput.hide");
      // 隐藏手机键盘方式2
      Focus.of(context).unfocus();
    }

    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            _searchBar(onBack, onCancel, onSearch),
            Consumer<SearchViewModel>(builder: (context, vm, child) {
              GestureTapCallback itemTap(int index) {
                return () {
                  var item = vm.searchList?[index];
                  // 跳转网页
                  RouteUtils.push(
                    context,
                    WebviewPage(
                      webViewType: WebViewType.URL,
                      loadResource: item?.link ?? '',
                      showTitle: true,
                      title: item?.title ?? '',
                    ),
                  );
                };
              }

              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => _listItem(
                      vm.searchList?[index].title ?? '', itemTap(index)),
                  itemCount: vm.searchList?.length ?? 0,
                ),
              );
            }),
          ],
        )),
      ),
    );
  }

  Widget _listItem(String? title, GestureTapCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        // 下横线
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.r, color: Colors.black12),
          ),
        ),
        child: Html(data: title ?? ''),
      ),
    );
  }

  Widget _searchBar(GestureTapCallback? onBack, GestureTapCallback? onCancel,
      ValueChanged<String>? onSearch) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      color: Colors.teal,
      height: 50.h,
      width: double.infinity,
      child: Row(
        children: [
          // 返回按钮
          GestureDetector(
            onTap: onBack,
            child:
                Icon(Icons.arrow_back_ios_new, size: 18.r, color: Colors.white),
          ),
          // 输入框
          Expanded(
            child: _roundBorderInput(onSearch),
          ),
          SizedBox(width: 5.w),
          GestureDetector(
            onTap: onCancel,
            child: Text(
              '取消',
              style: TextStyle(fontSize: 13.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _roundBorderInput(ValueChanged<String>? onSearch) {
    return Container(
      padding: EdgeInsets.all(6.r),
      child: TextField(
        // 键盘类型
        keyboardType: TextInputType.text,
        // 回车触发搜索
        textInputAction: TextInputAction.search,
        // 执行搜索
        onSubmitted: onSearch,
        controller: textEditingController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          // 光标居中
          contentPadding: EdgeInsets.only(left: 10.w),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
          ),
        ),
      ),
    );
  }
}
