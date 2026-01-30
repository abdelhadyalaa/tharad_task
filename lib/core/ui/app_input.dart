import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';

class AppInput extends StatefulWidget {
  final String? suffixIcon;
  final Color? vColor;
  final TextInputType? keyboardType;

  final String hint, label;
  final bool withCountryCode, isPassword,isNumber;
  final double? bottomSpace;

  const AppInput({
    super.key,
    this.suffixIcon,
    this.hint = "",
    this.label = "",
    this.withCountryCode = false,
    this.isPassword = false,
    this.bottomSpace,
    this.vColor,
    this.keyboardType,  this.isNumber=false ,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.bottomSpace ?? 16.h),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              keyboardType: widget.isNumber ? TextInputType.number : (widget.keyboardType ?? TextInputType.text),              validator: (value) {
                if (value == null || value.isEmpty) {
                  return widget.isPassword
                      ? "Please Put Your Password"
                      : 'Please Put Your Data';
                }
                return null;
              },
              obscureText: widget.isPassword && isHidden,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xffF4F7F6),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Color(0xffF0E6DE)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                labelText: widget.label,
                hintText: widget.hint,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        onPressed: () {
                          isHidden = !isHidden;
                          setState(() {});
                        },
                        icon: AppImage(
                          image: isHidden
                              ? "visibility_off.svg"
                              : "visibility.svg",
                        ),
                      )
                    : widget.suffixIcon != null
                    ? AppImage(image: widget.suffixIcon!, height: 18, width: 18)
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
