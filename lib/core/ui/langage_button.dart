import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({super.key});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  String _selectedLanguage = "ar";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _showSelectionSheet(context),

          child: Icon(Icons.language, color: const Color(0xff54B7BB)),
        ),
        SizedBox(width: 8.w),
        Text(
          _selectedLanguage == "en" ? "English" : "العربية",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  void _showSelectionSheet(BuildContext context) async {
    String tempSelection = _selectedLanguage;

    final String? result = await showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tempSelection == "en" ? "Select Language" : "اللغة",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: RadioListTile<String>(
                      activeColor: const Color(0xff54B7BB),
                      value: "ar",
                      groupValue: tempSelection,
                      title: const Text("اللغة العربية"),
                      onChanged: (value) =>
                          setSheetState(() => tempSelection = value!),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.grey),
                    ),

                    child: RadioListTile<String>(
                      activeColor: const Color(0xff54B7BB),
                      value: "en",
                      groupValue: tempSelection,
                      title: const Text("English"),
                      onChanged: (value) =>
                          setSheetState(() => tempSelection = value!),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () => Navigator.pop(context, tempSelection),
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        gradient: const LinearGradient(
                          colors: [Color(0xff54B7BB), Color(0xff265355)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8.r,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          tempSelection == "en" ? "Apply" : "تطبيق",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (result != null && result != _selectedLanguage) {
      setState(() {
        _selectedLanguage = result;
      });
    }
  }
}
