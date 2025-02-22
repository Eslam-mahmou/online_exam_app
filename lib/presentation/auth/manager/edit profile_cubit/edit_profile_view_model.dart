// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:injectable/injectable.dart';
//
// import '../../../../domain/common/result.dart';
// import '../../../../domain/entity/profile_user_entity.dart';
// import '../../../../domain/use_case/auth_use_case.dart';
// import 'edit_profile_state.dart';
//
// @injectable
// class EditProfileViewModel extends Cubit<EditProfileState> {
//   final AuthUseCase _authUseCase;
//
//   EditProfileViewModel(this._authUseCase) : super(EditProfileLoadingState());
//
//   final userNameController = TextEditingController();
//   final passwordNameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final GlobalKey<FormState> formEditProfileKey = GlobalKey<FormState>();
//
//   void doIntent(AuthEditProfileIntent intent) async {
//     switch (intent) {
//       case EditProfileClickedIntent():
//         _handleEditProfile();
//         break;
//     }
//   }
//
//   Future<void> _handleEditProfile() async {
//     if (!formEditProfileKey.currentState!.validate()) return;
//
//     EasyLoading.show();
//     emit(EditProfileLoadingState());
//
//     try {
//       var user = ProfileUserEntity(
//         username: userNameController.text,
//         firstName: firstNameController.text,
//         lastName: lastNameController.text,
//         email: emailController.text,
//         phone: phoneController.text,
//       );
//
//       // Pass the user object to the executeProfile method
//       final updatedUser = await _authUseCase.executeProfile(user);
//
//       log("Raw API Response: $updatedUser");
//       EasyLoading.dismiss();
//
//       switch (updatedUser) {
//         case Success():
//           var data = updatedUser.data;
//           log("✅ Parsed Profile Data: $data");
//
//           if (data != null) {
//             emit(SuccessEditProfileState(data));
//             log("✅ Profile updated successfully: ${data.lastName}");
//           } else {
//             emit(ErrorEditProfileState("Profile update failed"));
//             log("❌ Profile update error: Data is null");
//           }
//           break;
//
//         case Error():
//           emit(ErrorEditProfileState(updatedUser.exception.toString()));
//           log("❌ Profile update API Error: ${updatedUser.exception}");
//           break;
//       }
//     } catch (e, stacktrace) {
//       EasyLoading.dismiss();
//       emit(ErrorEditProfileState(e.toString()));
//
//       // Log full error details
//       log("Unexpected Profile Update Error: $e");
//       log("Stacktrace:\n$stacktrace");
//     }
//   }
// }
//
// sealed class AuthEditProfileIntent {}
//
// class EditProfileClickedIntent extends AuthEditProfileIntent {}
