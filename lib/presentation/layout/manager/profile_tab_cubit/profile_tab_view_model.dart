import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/profile_user_entity.dart';
import 'package:online_exam_app/domain/use_case/profile_use_case.dart';
import 'package:online_exam_app/presentation/layout/manager/profile_tab_cubit/profile_tab_state.dart';
@injectable
class ProfileTabViewModel extends Cubit<ProfileTabState> {
  ProfileTabViewModel(this._profileUseCase) : super(ProfileTabLoading());

  final ProfileUseCase _profileUseCase;
  ProfileUserEntity? user;

  void doIntent(ProfileTabIntent profileTabIntent) {
    switch (profileTabIntent) {
      case GetUserInfoIntent():
        _fetchUser();
      case EditProfileClickedIntent():
        if (profileTabIntent.user != null) {
          _handleEditProfile(profileTabIntent.user!);
        } else {
          emit(ProfileTabError("User data is missing"));
        }
    }
  }

  Future<void> _fetchUser() async {
    emit(ProfileTabLoading());
    var result = await _profileUseCase.callUser();

    switch (result) {
      case Success():
        var data = result.data;
        if (data?.message == "success") {
          log("Fetched user: ${data?.user}");
          user = data;
          emit(ProfileTabSuccess(user)); // Emit Success State
        } else {
          emit(ProfileTabError(data?.message ?? "Unknown error"));
        }
      case Error():
        emit(ProfileTabError(result.exception?.toString() ?? "API Error"));
    }
  }

  Future<void> _handleEditProfile(UserDataEntity updatedUser) async {
    emit(ProfileTabLoading());

    try {
      if (user == null || user!.user == null) {
        emit(ProfileTabError("User data is missing"));
        return;
      }

      // Create updated entity
      final updatedProfile = await _profileUseCase.executeProfile(
        ProfileUserEntity(
          user: UserDataEntity(
            id: user?.user?.id ?? "",
            username: updatedUser.username,
            firstName: updatedUser.firstName,
            lastName: updatedUser.lastName,
            email: updatedUser.email,
            phone: updatedUser.phone,
          ),
        ),
      );

      // Handle success case
      if (updatedProfile is Success<ProfileUserEntity>) {
        var updatedData = updatedProfile.data;
        if (updatedData != null) {
          user = updatedData;
          emit(ProfileTabSuccess(user)); // ✅ Emit success state
        }
      } else if (updatedProfile is Error) {
        emit(ProfileTabError(updatedProfile.toString() ?? "Update failed"));
      }
    } catch (e) {
      emit(ProfileTabError(e.toString()));
    }
  }
}

// Intent classes
sealed class ProfileTabIntent {}

class EditProfileClickedIntent extends ProfileTabIntent {
  final UserDataEntity user;

  EditProfileClickedIntent(this.user);
}

class GetUserInfoIntent extends ProfileTabIntent {}

///
// class ProfileTabViewModel extends Cubit<ProfileTabState>{
//   ProfileTabViewModel(this._profileUseCase) : super(ProfileTabLoading());
//  final ProfileUseCase _profileUseCase;
//  ProfileUserEntity? user;
//  void doIntent(ProfileTabIntent profileTabIntent){
//    switch (profileTabIntent){
//      case GetUserInfoIntent():
//        _fetchUser();
//      case EditProfileClickedIntent():
//        if (user?.user != null) {
//          _handleEditProfile(user!.user!); // ✅ Pass UserDataEntity
//        } else {
//          emit(ProfileTabError("User data is missing"));
//        }
//    }
//  }
//  void _fetchUser()async{
//    emit(ProfileTabLoading());
//    var result=await _profileUseCase.callUser();
//    switch (result){
//      case Success():
//        var data=result.data;
//        if(data!.message=="success"){
//          log(data.user.toString());
//          user=data;
//          log(user!.user.toString());
//          emit(ProfileTabSuccess(user));
//        }
//        else{
//          emit(ProfileTabError(data.message.toString()));
//        }
//      case Error():
//        emit(ProfileTabError(result.exception!.toString()));
//
//    }
//  }
//
//   Future<void> _handleEditProfile(UserDataEntity updatedUser) async {
//     emit(ProfileTabLoading());
//
//     try {
//       if (user == null || user!.user == null) {
//         emit(ProfileTabError("User data is missing"));
//         return;
//       }
//
//         // ProfileUserEntity(user: updatedUser), // ✅ Send new data
//       final updatedProfile = await _profileUseCase.executeProfile(
//       ProfileUserEntity(
//       user: UserDataEntity(
//       id: user?.user?.id ?? "", // ✅ Preserve existing ID
//       username: updatedUser.username,
//       firstName: updatedUser.firstName,
//       lastName: updatedUser.lastName,
//       email: updatedUser.email,
//       phone: updatedUser.phone,
//       ),
//     ),
//     );
//
//       if (updatedProfile is Success<ProfileUserEntity>) {
//         var updatedData = updatedProfile.data;
//         if (updatedData != null) {
//           user = updatedData; // ✅ Update local user data
//           emit(ProfileTabSuccess(null));
//           emit(ProfileTabSuccess(user)); // ✅ Emit success state
//
//           _fetchUser(); // ✅ Fetch fresh data from the API to ensure UI is updated
//         }
//       } else if (updatedProfile is Error) {
//         emit(ProfileTabError(updatedProfile.toString()));
//       }
//     } catch (e) {
//       emit(ProfileTabError(e.toString()));
//     }
//   }
// }
// sealed class ProfileTabIntent{}
// class EditProfileClickedIntent extends ProfileTabIntent {
//   ProfileUserEntity? user;
//   EditProfileClickedIntent(this.user);
// }
// class GetUserInfoIntent extends ProfileTabIntent{
//   UserDataEntity? user;
//   GetUserInfoIntent(this.user);
// }
///
// Future<void> _handleEditProfile() async {
//
//   emit(ProfileTabLoading());
//
//   try {
//
//     // Pass the user object to the executeProfile method
//     final updatedUser = await _profileUseCase.executeProfile(ProfileUserEntity());
//
//     log("Raw API Response: $updatedUser");
//     EasyLoading.dismiss();
//
//     switch (updatedUser) {
//       case Success():
//         var data = updatedUser.data;
//         log("✅ Parsed Profile Data: $data");
//
//         if (data != null) {
//           emit(ProfileTabSuccess(data));
//           log("✅ Profile updated successfully: ${data.user?.lastName}");
//         } else {
//           emit(ProfileTabError("Profile update failed"));
//           log("❌ Profile update error: Data is null");
//         }
//
//       case Error():
//         emit(ProfileTabError(updatedUser.exception.toString()));
//         log("❌ Profile update API Error: ${updatedUser.exception}");
//         break;
//     }
//   } catch (e, stacktrace) {
//     EasyLoading.dismiss();
//     emit(ProfileTabError(e.toString()));
//
//     // Log full error details
//     log("Unexpected Profile Update Error: $e");
//     log("Stacktrace:\n$stacktrace");
//   }
// }