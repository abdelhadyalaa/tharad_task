import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'app_image.dart';

class AppImageUpLoader extends StatefulWidget {
  const AppImageUpLoader({super.key});

  @override
  State<AppImageUpLoader> createState() => _AppImageUpLoaderState();
}

class _AppImageUpLoaderState extends State<AppImageUpLoader> {
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? selected = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (selected != null) {
      setState(() {
        _pickedImage = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        dashPattern: const [10, 10],
        radius: Radius.circular(8.r),

        color: const Color(0xff42867B),
        strokeWidth: 1,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF4F7F6),
          borderRadius: BorderRadius.circular(8.r),
        ),
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 120.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _showSelectionSheet(context),
              child: _pickedImage == null
                  ? Column(
                      children: [
                        AppImage(image: "camera.svg", bottomSpace: 6.h),
                        Text(
                          "الملفات المسموح بيها :  JPEG , PNG",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          "الحد الاقصي : 5MB",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(
                        File(_pickedImage!.path),
                        fit: BoxFit.cover,
                        width: 100.w,
                        height: 100.h,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "إضافة صورة",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xff42867B)),
                title: const Text("الكاميرا"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xff42867B),
                ),
                title: const Text("المعرض "),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
