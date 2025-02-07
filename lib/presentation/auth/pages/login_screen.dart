import 'package:flutter/material.dart';

import '../../../core/widget/custom_elevated_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in screen"),
      ),
      body: Center(
        child: CustomElevatedButton(
          onTap: () {},
          label: "Log in",
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
