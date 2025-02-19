import '../../../../domain/entity/profile_user_entity.dart';

sealed class EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class SuccessEditProfileState extends EditProfileState {
  final ProfileUserEntity updatedUser;

  SuccessEditProfileState(this.updatedUser);

  List<Object?> get props => [updatedUser];
}

class ErrorEditProfileState extends EditProfileState {
  final String? errMessage;

  ErrorEditProfileState(this.errMessage);
}
