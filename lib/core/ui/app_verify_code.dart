import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppVerifyCode extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const AppVerifyCode({super.key, required this.onChanged});

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
        cursorColor: const Color(0x10101038).withValues(alpha: .22),
        length: 4,
        mainAxisAlignment: MainAxisAlignment.center,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        onChanged: onChanged,
        pinTheme: PinTheme(
          fieldHeight: 50.h,
          fieldWidth: 50.w,
          borderRadius: BorderRadius.circular(8.r),
          selectedColor: const Color(0xffD75D72),
          activeFillColor: Colors.white,
          activeColor: const Color(0xffD75D72),
          borderWidth: 1,
          inactiveColor: const Color(0x8989925C).withValues(alpha: .36),
          shape: PinCodeFieldShape.box,
        ),
      ),
    );
  }
}
