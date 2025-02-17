import 'package:equatable/equatable.dart';

class UserResponse {
  final String message;
  final String token;
  final UserModel user;

  UserResponse(
      {required this.message, required this.token, required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json["message"] ?? "",
      token: json["token"] ?? "",
      user: UserModel.fromJson(json["user"]),
    );
  }
}

class UserModel extends Equatable {
  String? id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  String? role;
  bool? isVerified;

  UserModel({
    this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.role,
    required this.password,
    this.isVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"] ?? "",
      username: json["username"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      password: json["password"] ?? "",
      role: json["role"] ?? "",
      isVerified: json["isVerified"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "rePassword": password,
      "phone": phone
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [username, email];
}
