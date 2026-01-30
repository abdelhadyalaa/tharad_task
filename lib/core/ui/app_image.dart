import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class AppImage extends StatelessWidget {
  final String image;
  final double? height, width, bottomSpace;
  final bool isCircle;
  final Color? color;
  final BoxFit fit;

  const AppImage({
    super.key,
    required this.image,
    this.height,
    this.width,

    this.color,
    this.fit = BoxFit.scaleDown,
    this.bottomSpace,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final myFit = isCircle ? BoxFit.cover : fit;
    if (image.isEmpty)return SizedBox.shrink();
    return Padding(
      padding: bottomSpace != null
          ? EdgeInsets.only(bottom: bottomSpace!)
          : EdgeInsets.zero,
      child: Builder(
        builder: (context) {
          Widget child;

          if (image.toLowerCase().endsWith("svg")) {
            child = SvgPicture.asset(
              "assets/icons/$image",
              color: color,
              height: height,
              width: width,
              fit: myFit,
            );
          } else if (image.startsWith("http")) {
            child = Image.network(
              image,
              height: height,
              width: width,
              color: color,
              fit: myFit,
            );
          } else if (image.endsWith("json")) {
            child = Lottie.asset(
              "assets/lotties/$image",
              height: height,
              width: width,
              fit: myFit,
            );
          } else {
            child = Image.asset(
              "assets/images/$image",
              height: height,
              width: width,
              color: color,
              fit: myFit,
            );
          }

          if (isCircle) return ClipOval(child: child);
          return child;
        },
      ),
    );
  }
}
