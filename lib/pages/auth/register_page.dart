import 'package:flutter/material.dart';
import 'package:flutter_project/common-ui/common_text_form_input.dart';
import 'package:flutter_project/common-ui/common_text_input.dart';
import 'package:flutter_project/common-ui/common_large_button.dart';
import 'package:flutter_project/pages/auth/auth_vm.dart';
import 'package:flutter_project/router/route_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthViewModel viewModel = AuthViewModel();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          alignment: Alignment.center,
          // child: _textFieldWidget(),
          child: _textFormFieldWidget(_formKey),
        ),
      ),
    );
  }

  Widget _textFieldWidget() {
    return Consumer<AuthViewModel>(
      builder: (context, vm, child) {
        Future handleRegister() async {
          bool isSuccess = await vm.register();
          if (isSuccess == true) {
            showToast("注册成功");
            RouteUtils.pop(context);
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonTextInput(
              labelText: "账号",
              onChanged: (value) => vm.registerInfo.name = value,
            ),
            SizedBox(height: 20.h),
            CommonTextInput(
              obscureText: true,
              labelText: "密码",
              onChanged: (value) => vm.registerInfo.password = value,
            ),
            SizedBox(height: 20.h),
            CommonTextInput(
              obscureText: true,
              labelText: "确认密码",
              onChanged: (value) => vm.registerInfo.rePassword = value,
            ),
            SizedBox(height: 40.h),
            // 注册按钮
            CommonLargeButton(
              title: '注册',
              onTap: handleRegister,
            ),
          ],
        );
      },
    );
  }

  Widget _textFormFieldWidget(GlobalKey<FormState> formKey) {
    return Consumer<AuthViewModel>(
      builder: (context, vm, child) {
        Future handleRegister() async {
          if (formKey.currentState?.validate() == true) {
            // _formKey.currentState?.save();
            bool isSuccess = await vm.register();
            if (isSuccess == true) {
              showToast("注册成功");
              RouteUtils.pop(context);
            }
          }
        }

        String? nameValidator(String? name) {
          if (name == null || name.isEmpty) {
            return '请输入账号';
          } else if (name.length < 3) {
            return '用户名长度必须大于等于3';
          } else {
            return null;
          }
        }

        String? passwordValidator(String? password) {
          if (password == null || password.isEmpty) {
            return '请输入密码';
          } else if (password.length < 6) {
            return '密码长度必须大于等于6位';
          } else {
            return null;
          }
        }

        String? repasswordValidator(String? repassword) {
          if (repassword == null || repassword.isEmpty) {
            return '请输入确认密码';
          } else if (repassword.length < 6) {
            return '密码长度必须大于等于6位';
          } else {
            return null;
          }
        }

        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonTextFormInput(
                labelText: "账号",
                valueSetter: (value) => vm.registerInfo.name = value,
                valueValidator: nameValidator,
              ),
              SizedBox(height: 20.h),
              CommonTextFormInput(
                obscureText: true,
                labelText: "密码",
                valueSetter: (value) => vm.registerInfo.password = value,
                valueValidator: passwordValidator,
              ),
              SizedBox(height: 20.h),
              CommonTextFormInput(
                obscureText: true,
                labelText: "确认密码",
                valueSetter: (value) => vm.registerInfo.rePassword = value,
                valueValidator: repasswordValidator,
              ),
              SizedBox(height: 40.h),
              // 注册按钮
              CommonLargeButton(
                title: '注册',
                onTap: handleRegister,
              ),
            ],
          ),
        );
      },
    );
  }
}
