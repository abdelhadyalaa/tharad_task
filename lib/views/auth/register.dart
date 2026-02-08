import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tharad_task/core/logic/helper_methods.dart';
import 'package:tharad_task/core/ui/app_image.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/end_points.dart';
import '../../core/ui/app_button.dart';
import '../../core/ui/app_button_underLine.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/app_upload_image.dart';
import 'login.dart';
import 'otp.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? imagePath;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),
                AppImage(
                  image: "logo.png",
                  width: 178.w,
                  height: 58.h,
                  bottomSpace: 40.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "إنشاء حساب جديد",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 16.h),
                Text(
                  "الصورة الشخصية",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 6.h),
                AppImageUpLoader(
                  onImagePicked: (path) {
                    imagePath = path;
                  },
                ),
                SizedBox(height: 12.h),
                Text(
                  "اسم المستخدم",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                AppInput(
                  controller: nameController,
                  bottomSpace: 12,
                  label: "thar22",
                ),
                Text(
                  "البريد الإلكتروني",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
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
                  bottomSpace: 12,
                  label: "Password",
                  isPassword: true,
                ),
                Text(
                  "تأكيد كلمة المرور",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                AppInput(
                  controller: confirmPasswordController,
                  bottomSpace: 30,
                  label: "Confirm Password",
                  isPassword: true,
                ),

                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : AppButton(
                        text: "إنشاء حساب",
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            _register();
                          }
                        },
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("لديك حساب؟"),
                    AppButtonUnderline(
                      text: " تسجيل الدخول",
                      onPressed: () => goTo(page: const LoginView()),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    if (imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("برجاء اختيار صورة شخصية"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => isLoading = true);
    try {
      final api = DioHelper(dio: Dio());

      FormData formData = FormData.fromMap({
        "username": nameController.text.trim().replaceAll(" ", ""),
        "email": emailController.text,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
        "image": await MultipartFile.fromFile(
          imagePath!,
          filename: imagePath!.split('/').last,
        ),
      });

      final response = await api.postData(EndPoints.register, data: formData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message'] ?? "تم التسجيل بنجاح"),
          backgroundColor: Colors.green,
        ),
      );
      goTo(page: OtpView(email: emailController.text));
    } catch (e) {
      String errorMessage = "حدث خطأ ما";

      if (e is DioException) {
        errorMessage = e.response?.data['message'] ?? "خطأ من السيرفر";
      } else {
        errorMessage = e.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
