import 'package:injectable/injectable.dart';
import 'package:online_exam_app/core/api/ApiExcuter.dart';
import 'package:online_exam_app/data/data_source/remote_data_source/profile_remote_data_source.dart';
import 'package:online_exam_app/data/model/profile_user.dart';
import 'package:online_exam_app/domain/common/result.dart';
import 'package:online_exam_app/domain/entity/profile_user_entity.dart';
import 'package:online_exam_app/domain/repository/profile_repository.dart';
@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository{
  ProfileRepositoryImpl(this._profile);
 final ProfileRemoteDataSource _profile;
  @override
  Future<Result<ProfileUserEntity>> getUserInfo() {
    return executeApi<ProfileUserEntity>(
      ()async {
        var response=await _profile.getUserInfo();
        var data=ProfileUserModel.fromJson(response.data);
        return data;
      },
    );
  }

}