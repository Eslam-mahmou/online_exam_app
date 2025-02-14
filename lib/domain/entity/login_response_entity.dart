import 'package:equatable/equatable.dart';

class LoginResponseEntity {
  LoginResponseEntity({
      this.message, 
      this.token, 
      this.user,});
  String? message;
  String? token;
  UserLoginResponseEntity? user;

}

class UserLoginResponseEntity extends Equatable {
  UserLoginResponseEntity({
      this.id, 
      this.username, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.phone,
      this.isVerified,});


  String? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  bool? isVerified;

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    username
  ];


}