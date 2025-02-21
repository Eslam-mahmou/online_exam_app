import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_exam_app/core/Utils/colors_manager.dart';
import 'package:online_exam_app/core/Utils/font_manager.dart';
import 'package:online_exam_app/core/Utils/style_manager.dart';
import 'package:online_exam_app/core/routes_generator/pages_routes.dart';
import 'package:online_exam_app/core/widget/custom_elevated_button.dart';
import 'package:online_exam_app/core/widget/custom_text_from_field.dart';
import 'package:online_exam_app/core/widget/custom_validate.dart';
import 'package:online_exam_app/domain/entity/login_response_entity.dart';
import 'package:online_exam_app/presentation/auth/manager/edit%20profile_cubit/edit_profile_state.dart';
import 'package:online_exam_app/presentation/auth/manager/edit%20profile_cubit/edit_profile_view_model.dart';
import 'package:online_exam_app/presentation/layout/widget/custom_picker_image.dart';

import '../../../../data/model/profile_user.dart';
import '../../../../di/injectable_initializer.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late EditProfileViewModel viewModel;
  UserLoginResponseEntity? userData;
  bool isUserDataLoaded = false; // Flag to track data loading

  @override
  void initState() {
    super.initState();
    viewModel = getIt.get<EditProfileViewModel>();

    // Retrieve user data after UI is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is UserLoginResponseEntity) {
        setState(() {
          userData = args;
          isUserDataLoaded = true; // Data has been loaded
        });
        _populateUserData(userData!);
      } else {
        print("❌ Error: Unknown argument type ${args.runtimeType}");
      }
    });
  }

  void _populateUserData(UserLoginResponseEntity user) {
    viewModel.userNameController.text = user.username ?? '';
    viewModel.firstNameController.text = user.firstName ?? '';
    viewModel.lastNameController.text = user.lastName ?? '';
    viewModel.emailController.text = user.email ?? '';
    viewModel.phoneController.text = user.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (!isUserDataLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    return BlocProvider(
      create: (context) => viewModel,
      child: BlocListener<EditProfileViewModel, EditProfileState>(
        listener: (context, state) {
          if (state is SuccessEditProfileState) {
            EasyLoading.dismiss();
            var updatedUser = state.updatedUser;

            if (updatedUser != null) {
              //  ProfileUserEntity ----> ProfileUserModel
              var convertedUser = ProfileUserModel.fromEntity(
                  updatedUser); // convert instead of cast
              _populateUserData(convertedUser);
              // _populateUserData(updatedUser as UserLoginResponseEntity);
              print("✅ Success: Updated Profile Data: ${updatedUser.toJson()}");
            } else {
              print("❌ Error: Updated user data is null.");
            }
          }

          if (state is ErrorEditProfileState) {
            EasyLoading.dismiss();
            print("❌ Error: ${state.errMessage}");
          }
        },
        child: BlocBuilder<EditProfileViewModel, EditProfileState>(
          builder: (context, state) {
            return _buildProfileForm();
          },
        ),
      ),
    );
  }

  Widget _buildProfileForm() {
    return SingleChildScrollView(
      child: Form(
        key: viewModel.formEditProfileKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 45.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Profile",
                style: getTextStyle(FontSize.s20, FontWeightManager.medium,
                    ColorsManager.blackColor),
              ),
            ),
            SizedBox(height: 16.h),
            const CustomPickerImage(),
            SizedBox(height: 16.h),
            CustomTextFromField(
              validator: AppValidate.validateUserName,
              labelText: "User name",
              controller: viewModel.userNameController,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: CustomTextFromField(
                    validator: AppValidate.validateFullName,
                    controller: viewModel.firstNameController,
                    labelText: "First name",
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: CustomTextFromField(
                    validator: AppValidate.validateFullName,
                    controller: viewModel.lastNameController,
                    labelText: "Last name",
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            CustomTextFromField(
              validator: AppValidate.validateEmail,
              controller: viewModel.emailController,
              labelText: "Email",
            ),
            SizedBox(height: 16.h),
            CustomTextFromField(
              obscureText: true,
              validator: AppValidate.validatePassword,
              controller: viewModel.passwordNameController,
              labelText: "Password",
              suffix: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, PagesRoutes.resetPassword);
                },
                child: Text(
                  "Change",
                  textAlign: TextAlign.center,
                  style: getTextStyle(FontSize.s12, FontWeightManager.semiBold,
                      ColorsManager.primaryColor),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextFromField(
              validator: AppValidate.validateMobile,
              controller: viewModel.phoneController,
              labelText: "Phone number",
            ),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              label: "Update",
              onTap: () {
                if (viewModel.formEditProfileKey.currentState!.validate()) {
                  viewModel.doIntent(EditProfileClickedIntent());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
