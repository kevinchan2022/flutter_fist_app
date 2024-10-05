import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/common_text_form_input.dart';
import 'package:flutter_project/common-ui/common_large_button.dart';
import 'package:flutter_project/pages/auth/auth_vm.dart';
import 'package:flutter_project/pages/auth/register_page.dart';
import 'package:flutter_project/pages/layout/layout_page.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  AuthViewModel viewModel = AuthViewModel();

  late TextEditingController? nameController;
  late TextEditingController? passwordController;

  Future handleLogin() async {
    if (_formKey.currentState?.validate() == true) {
      viewModel.setLoginInfo(
        name: nameController?.text,
        password: passwordController?.text,
      );
      bool isSuccess = await viewModel.login();
      if (isSuccess == true) {
        // 跳转并清空当前的路由栈
        RouteUtils.pushAndRemoveUtil(context, const LayoutPage());
      }
    }
  }

  String? usernameValidator(name) {
    if (name == null || name.isEmpty) {
      return '请输入账号';
    } else {
      return null;
    }
  }

  String? passwordValidator(password) {
    if (password == null || password.isEmpty) {
      return '请输入密码';
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          alignment: Alignment.center,
          child: _loginForm(),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommonTextFormInput(
            labelText: "账号",
            controller: nameController,
            valueValidator: usernameValidator,
          ),
          SizedBox(height: 20.h),
          CommonTextFormInput(
            obscureText: true,
            labelText: "密码",
            controller: passwordController,
            valueValidator: passwordValidator,
          ),
          SizedBox(height: 40.h),
          // 登录按钮
          CommonLargeButton(
            title: '登录',
            onTap: handleLogin,
          ),
          SizedBox(height: 10.h),
          // 注册
          _registerButton(() => RouteUtils.push(context, const RegisterPage())),
        ],
      ),
    );
  }

  Widget _registerButton(GestureTapCallback? onTab) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          '注册',
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ),
    );
  }
}
