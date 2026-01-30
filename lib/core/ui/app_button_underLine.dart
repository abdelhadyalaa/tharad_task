import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtonUnderline extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLogout;

  const AppButtonUnderline({super.key, this.text="", this.onPressed,  this.isLogout=false});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed??() {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,

      ),
      child: Text(
        text,
        style: TextStyle(
          color: isLogout?Colors.red:Color(0xff42867B),
          decoration: TextDecoration.underline,
          decorationColor: isLogout?Colors.red:Color(0xff42867B),
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
