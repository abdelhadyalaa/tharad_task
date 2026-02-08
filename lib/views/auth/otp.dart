import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_task/core/logic/dio_helper.dart';
import 'package:tharad_task/core/logic/end_points.dart';
import 'package:tharad_task/core/logic/helper_methods.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_resend_otp.dart';
import '../../core/ui/app_verify_code.dart';
import 'login.dart';

class OtpView extends StatefulWidget {
  final String email;
  const OtpView({super.key, required this.email});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String? otpCode;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 80.h),
              AppImage(
                image: "logo.png",
                bottomSpace: 100.h,
                width: 178.w,
                height: 58.h,
              ),
              Text(
                "رمز التحقق",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8.h),
              Text(
                "لاستكمال فتح حسابك ادخل رمز التحقق المرسل عبر البريد الإلكتروني \n ${widget.email}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 30.h),

              // تم ربط onChanged لاستلام الكود
              AppVerifyCode(
                onChanged: (value) {
                  otpCode = value;
                },
              ),

              const AppResendOtp(),
              SizedBox(height: 40.h),

              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : AppButton(
                text: "المتابعة",
                onPressed: () {
                  // التأكد من إدخال 4 أرقام (حسب السيرفر عندك)
                  if (otpCode != null && otpCode!.length >= 4) {
                    _verifyOtp();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("يرجى إدخال كود التحقق كاملاً")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verifyOtp() async {
    setState(() => isLoading = true);

    try {
      final api = DioHelper(dio: Dio());

      final response = await api.getData(
        EndPoints.verifyOtp,
        queryParameters: {
          "email": widget.email,
          "otp": otpCode,
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['message'] ?? "تم التحقق بنجاح"),
          backgroundColor: Colors.green,
        ),
      );

      goTo(page: const LoginView());

    } catch (e) {
      String errorMessage = "كود التحقق غير صحيح";
      if (e is DioException) {
        errorMessage = e.response?.data['message'] ?? "حدث خطأ أثناء التفعيل";
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
}