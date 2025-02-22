import 'package:online_exam_app/domain/entity/profile_user_entity.dart';

sealed class ProfileTabState{

}
class ProfileTabLoading extends ProfileTabState{}

class ProfileTabSuccess extends ProfileTabState{
  ProfileUserEntity? user;
  ProfileTabSuccess(this.user);
}
class ProfileTabError extends ProfileTabState{
  final String errMessage;
  ProfileTabError(this.errMessage);
}