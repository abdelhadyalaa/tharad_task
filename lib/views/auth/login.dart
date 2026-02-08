import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_task/views/home/view.dart';

import '../../core/logic/dio_helper.dart';
import '../../core/logic/end_points.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_button_underLine.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_remember_check.dart';
import '../../core/ui/langage_button.dart';
import 'register.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.h),
                const LanguageButton(),
                SizedBox(height: 80.h),
                AppImage(
                  image: "logo.png",
                  bottomSpace: 100.h,
                  width: 178.w,
                  height: 58.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "تسجيل الدخول",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "البريد الإلكتروني",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 6.h),
                AppInput(
                  controller: emailController,
                  bottomSpace: 12,
                  label: "Tharad@gmail.com",
                ),
                Text(
                  "كلمة المرور",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                AppInput(
                  controller: passwordController,
                  bottomSpace: 4,
                  label: "Password",
                  isPassword: true,
                ),
                const Row(
                  children: [
                    RememberMeCheckbox(),
                    Spacer(),
                    AppButtonUnderline(text: "هل نسيت كلمة المرور؟"),
                  ],
                ),
                SizedBox(height: 20.h),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AppButton(
                        text: "تسجيل الدخول",
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            _login();
                          }
                        },
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("ليس لديك حساب؟"),
                    AppButtonUnderline(
                      text: "إنشاء حساب جديد",
                      onPressed: () {
                        goTo(page: const RegisterView(), canPop: false);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    setState(() => isLoading = true);
    try {
      final api = DioHelper(dio: Dio());
      final response = await api.postData(
        EndPoints.login,
        data: {
          "email": emailController.text.trim(),
          "password": passwordController.text,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message'] ?? "تم تسجيل الدخول بنجاح"),
          backgroundColor: Colors.green,
        ),
      );

      goTo(page: const HomeView());
    } catch (e) {
      String errorMessage = "حدث خطأ ما";
      if (e is DioException) {
        errorMessage = e.response?.data['message'] ?? "بيانات الدخول غير صحيحة";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
