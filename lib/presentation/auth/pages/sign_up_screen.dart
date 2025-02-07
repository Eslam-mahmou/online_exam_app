import 'package:flutter/material.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: CustomTextFromField(labelText: "wcjk",hinText: "Text",),
    );
  }
}
