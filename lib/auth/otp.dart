import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_task/core/logic/helper_methods.dart';

import '../../core/ui/app_button.dart';
import '../../core/ui/app_image.dart';
import '../../core/ui/app_resend_otp.dart';
import '../../core/ui/app_verify_code.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

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
                textAlign: TextAlign.center,
                "رمز التحقق",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8.h),

              Text(
                textAlign: TextAlign.center,
                " لاستكمال فتح حسابك ادخل رمز التحقق المرسل عبر البريد \nالإلكتروني",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 6.h),
              AppVerifyCode(),
              AppResendOtp(),

              SizedBox(height: 40.h),
              AppButton(text: "المتابعة", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
