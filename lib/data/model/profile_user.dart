import '../../domain/entity/profile_user_entity.dart';

class ProfileUserModel extends ProfileUserEntity {
   ProfileUserModel({super.message, super.user});
   ProfileUserModel.fromJson(Map<String,dynamic>json){
     message = json['message'];
     user = UserDataModel.fromJson(json['user']);
   }
}

class UserDataModel extends UserDataEntity {
  UserDataModel(
      {
        super.id,
        super.username,
       super.firstName,
       super.lastName,
       super.email,
       super.phone});
 UserDataModel.fromJson(Map<String ,dynamic>json){
   id = json['_id'];
   username = json['username'];
   firstName = json['firstName'];
   lastName = json['lastName'];
   email = json['email'];
   phone = json['phone'];
 }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
    };
  }
}
