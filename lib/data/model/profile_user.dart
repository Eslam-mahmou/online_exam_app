import '../../domain/entity/profile_user_entity.dart';

class ProfileUserModel extends ProfileUserEntity {
  ProfileUserModel({
    required String id,
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String role,
    required bool isVerified,
    String? passwordResetCode,
    String? passwordResetExpires,
    bool? resetCodeVerified,
  }) : super(
          id: id,
          username: username,
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          role: role,
          isVerified: isVerified,
          passwordResetCode: passwordResetCode,
          passwordResetExpires: passwordResetExpires,
          resetCodeVerified: resetCodeVerified,
        );

  // Factory constructor to convert JSON to ProfileUserModel
  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    return ProfileUserModel(
      id: json["_id"] ?? "",
      username: json["username"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      role: json["role"] ?? "",
      isVerified: json["isVerified"] is bool
          ? json["isVerified"] as bool
          : json["isVerified"] == "false",
      passwordResetCode: json["passwordResetCode"],
      passwordResetExpires: json["passwordResetExpires"],
      resetCodeVerified: json["resetCodeVerified"] is bool
          ? json["resetCodeVerified"] as bool
          : json["resetCodeVerified"] == "true",
    );
  }

  // Convert ProfileUserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "role": role,
      "isVerified": isVerified,
      "passwordResetCode": passwordResetCode,
      "passwordResetExpires": passwordResetExpires,
      "resetCodeVerified": resetCodeVerified,
    };
  }
}
