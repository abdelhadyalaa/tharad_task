import 'package:flutter/material.dart';
import 'app_image.dart';

class AppButton extends StatelessWidget {
  final String text;
  final String? icon;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final double borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.height = 50,
    this.width,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: const LinearGradient(
            colors: [Color(0xff54B7BB), Color(0xff265355)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                AppImage(image: icon!, height: 20, width: 20),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
