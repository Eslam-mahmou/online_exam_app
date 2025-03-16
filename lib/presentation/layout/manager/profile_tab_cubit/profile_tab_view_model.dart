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
        _handleEditProfile(profileTabIntent.user);
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
      if (updatedProfile is Success<ProfileUserEntity>) {
        var updatedData = updatedProfile.data;
        if (updatedData != null) {
          user = updatedData;
          emit(ProfileTabSuccess(user));
        }
      } else if (updatedProfile is Error) {
        emit(ProfileTabError(updatedProfile.toString()));
      }
    } catch (e) {
      emit(ProfileTabError(e.toString()));
    }
  }
}

sealed class ProfileTabIntent {}

class EditProfileClickedIntent extends ProfileTabIntent {
  final UserDataEntity user;

  EditProfileClickedIntent(this.user);
}

class GetUserInfoIntent extends ProfileTabIntent {}