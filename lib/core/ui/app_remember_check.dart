import 'package:flutter/material.dart';

class RememberMeCheckbox extends StatefulWidget {
  const RememberMeCheckbox({super.key});

  @override
  State<RememberMeCheckbox> createState() => _RememberMeCheckboxState();
}

class _RememberMeCheckboxState extends State<RememberMeCheckbox> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: rememberMe,
          onChanged: (val) {
            setState(() {
              rememberMe = val ?? false;
            });
          },
          activeColor: Colors.green,
          checkColor: Colors.white,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Text("تذكرني", style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
