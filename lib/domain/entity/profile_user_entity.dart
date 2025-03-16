import 'package:equatable/equatable.dart';

class ProfileUserEntity {
  String? message;
  UserDataEntity? user;

  ProfileUserEntity({this.message, this.user});
}

class UserDataEntity extends Equatable {
   String? id;
   String? username;
   String? firstName;
   String? lastName;
   String? email;
   String? phone;

   UserDataEntity({
    this.id,
     this.username,
     this.firstName,
     this.lastName,
     this.email,
     this.phone,
  });

  @override
  List<Object?> get props => [id, email,
  firstName, lastName, phone, username];
}
