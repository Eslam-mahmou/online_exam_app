import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';

import '../../../../core/Utils/colors_manager.dart';
import '../../../../core/Utils/font_manager.dart';
import '../../../../core/Utils/style_manager.dart';
import '../../../../core/widget/custom_elevated_button.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();

  void _onChanged(String value, FocusNode nextFocusNode) {
    if (value.length == 1) {
      FocusScope.of(context).requestFocus(nextFocusNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password"),
      ),
      body: Column(
        children: [
          Text(
            "Email verification",
            style: getTextStyle(FontSize.s18, FontWeightManager.medium,
                ColorsManager.blackColor),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            "Please enter your code that send to your\n email address",
            textAlign: TextAlign.center,
            style: getTextStyle(
              FontSize.s14,
              FontWeightManager.regular,
              ColorsManager.greyColor,
              height: 1.4.h,
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.blueLightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      focusNode: _focusNode1,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      onChanged: (value) => _onChanged(value, _focusNode2),
                      // validator: validator,
                      // obscureText: obscureText,
                      style: getTextStyle(FontSize.s16,
                          FontWeightManager.regular, ColorsManager.blackColor,
                          fontFamily: FontFamily.roboto),
                      decoration: InputDecoration(
                        counterText: "",
                        label: const Text(''),
                        labelStyle: getTextStyle(FontSize.s12,
                            FontWeightManager.regular, ColorsManager.greyColor,
                            fontFamily: FontFamily.roboto),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.greyColor, width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.redColor, width: 1)),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.blueLightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      focusNode: _focusNode2,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      onChanged: (value) => _onChanged(value, _focusNode3),
                      // validator: validator,
                      // obscureText: obscureText,
                      style: getTextStyle(FontSize.s16,
                          FontWeightManager.regular, ColorsManager.blackColor,
                          fontFamily: FontFamily.roboto),
                      decoration: InputDecoration(
                        counterText: "",
                        label: const Text(''),
                        labelStyle: getTextStyle(FontSize.s12,
                            FontWeightManager.regular, ColorsManager.greyColor,
                            fontFamily: FontFamily.roboto),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.greyColor, width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.redColor, width: 1)),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.blueLightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      focusNode: _focusNode3,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      onChanged: (value) => _onChanged(value, _focusNode4),
                      // validator: validator,
                      // obscureText: obscureText,
                      style: getTextStyle(FontSize.s16,
                          FontWeightManager.regular, ColorsManager.blackColor,
                          fontFamily: FontFamily.roboto),
                      decoration: InputDecoration(
                        counterText: "",
                        label: const Text(''),
                        labelStyle: getTextStyle(FontSize.s12,
                            FontWeightManager.regular, ColorsManager.greyColor,
                            fontFamily: FontFamily.roboto),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.greyColor, width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.redColor, width: 1)),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.blueLightColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      focusNode: _focusNode4,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      // onChanged: (value) => _onChanged(value,_focusNode4),
                      // validator: validator,
                      // obscureText: obscureText,
                      style: getTextStyle(FontSize.s16,
                          FontWeightManager.regular, ColorsManager.blackColor,
                          fontFamily: FontFamily.roboto),
                      decoration: InputDecoration(
                        counterText: "",
                        label: const Text(''),
                        labelStyle: getTextStyle(FontSize.s12,
                            FontWeightManager.regular, ColorsManager.greyColor,
                            fontFamily: FontFamily.roboto),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.greyColor, width: 1)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: ColorsManager.redColor, width: 1)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive code?",
                style: getTextStyle(FontSize.s16, FontWeightManager.regular,
                    ColorsManager.blackColor),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Resend",
                    style: getTextStyle(FontSize.s16, FontWeightManager.regular,
                        ColorsManager.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.primaryColor)),
              ),
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomElevatedButton(
            label: 'Continue',
            onTap: () {
              Navigator.pushNamed(context, PagesRoutes.resetPassLogin);
            },
            backgroundColor: ColorsManager.primaryColor,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    super.dispose();
  }
}
