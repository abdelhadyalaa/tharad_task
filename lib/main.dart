import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tharad_task/views/auth/login.dart';
import 'package:tharad_task/views/auth/otp.dart';
import 'package:tharad_task/views/home/view.dart';

import 'core/logic/helper_methods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Tajawal',
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xff0D1D1E),
            ),
            titleMedium: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff0D1D1E),
            ),
            titleSmall: TextStyle(fontSize: 6, fontWeight: FontWeight.w400),
          ),
          scaffoldBackgroundColor: Color(0xffFFFFFF),
          primaryColor: Color(0xff2C6062),
        ),
        home: HomeView(),
        navigatorKey: navKey,
        builder: (context, child) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            ),
          );
        },
      ),
    );
  }
}
