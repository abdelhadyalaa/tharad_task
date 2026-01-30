import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppResendOtp extends StatefulWidget {
  const AppResendOtp({super.key});

  @override
  State<AppResendOtp> createState() => _AppResendOtpState();
}

class _AppResendOtpState extends State<AppResendOtp> {
  bool isCodeSent = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          if (isCodeSent)
            Expanded(
              child: CircularCountDownTimer(
                onComplete: () {
                  isCodeSent = false;
                  setState(() {});
                },
                width: 40.w,
                height: 50.h,
                duration: 10,
                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                textFormat: CountdownTextFormat.MM_SS,
                fillColor: Colors.transparent,
                ringColor: Colors.transparent,
                isReverse: true,
              ),
            ),
          Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "ليس لديك حساب؟",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: isCodeSent
                    ? null
                    : () {
                        isCodeSent = true;
                        setState(() {});
                      },
                child: Text(
                  "إعادة الارسال",
                  style: TextStyle(
                    color: Color(0xff42867B),
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff42867B),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
