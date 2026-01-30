import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppVerifyCode extends StatelessWidget {
  const AppVerifyCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        appContext: context,
        cursorHeight: 16.h,
        cursorWidth: 5.w,
        hintCharacter: "_",
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        cursorColor: Color(0x10101038).withValues(alpha: .22),
        length: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        pinTheme: PinTheme(
          fieldHeight: 50,
          fieldWidth: 50,
          borderRadius: BorderRadius.circular(8.r),
          selectedColor: Color(0xffD75D72),

          activeFillColor: Colors.white,
          activeColor: Color(0xffD75D72),
          borderWidth: 1,
          inactiveColor: Color(0x8989925C).withValues(alpha: .36),
          shape: PinCodeFieldShape.box,
        ),
      ),
    );
  }
}
