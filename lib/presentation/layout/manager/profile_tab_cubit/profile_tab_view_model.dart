import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:online_exam_app/data/model/profile_user.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/profile_user_entity.dart';
import 'package:online_exam_app/domain/use_case/profile_use_case.dart';
import 'package:online_exam_app/presentation/layout/manager/profile_tab_cubit/profile_tab_state.dart';
@injectable
class ProfileTabViewModel extends Cubit<ProfileTabState>{
  ProfileTabViewModel(this._profileUseCase) : super(ProfileTabLoading());
 final ProfileUseCase _profileUseCase;
 ProfileUserEntity? user;
 void doIntent(ProfileTabIntent profileTabIntent){
   switch (profileTabIntent){
     case GetUserInfoIntent():
       _fetchUser();
   }
 }
 void _fetchUser()async{
   emit(ProfileTabLoading());
   var result=await _profileUseCase.callUser();
   switch (result){
     case Success():
       var data=result.data;
       if(data!.message=="success"){
         log(data.user.toString());
         user=data;
         log(user!.user.toString());
         emit(ProfileTabSuccess(user));
       }
       else{
         emit(ProfileTabError(data.message.toString()));
       }
     case Error():
       emit(ProfileTabError(result.exception!.toString()));

   }
 }
}
sealed class ProfileTabIntent{

}
class GetUserInfoIntent extends ProfileTabIntent{
  UserDataEntity? user;
  GetUserInfoIntent(this.user);
}