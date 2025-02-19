import '../../domain/entity/login_response_entity.dart';
import '../../domain/entity/profile_user_entity.dart';

class ProfileUserModel extends UserLoginResponseEntity {
  ProfileUserModel({
    super.id,
    super.username,
    super.firstName,
    super.lastName,
    super.email,
    super.phone,
    super.isVerified,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
  });

  String? passwordResetCode;
  String? passwordResetExpires;
  bool? resetCodeVerified;

  // change ProfileUserModel to ProfileUserEntity
  ProfileUserEntity toEntity() {
    return ProfileUserEntity(
      id: id,
      username: username.toString(),
      firstName: firstName.toString(),
      lastName: lastName.toString(),
      email: email.toString(),
      phone: phone.toString(),
      isVerified: isVerified,
      passwordResetCode: passwordResetCode,
      passwordResetExpires: passwordResetExpires,
      resetCodeVerified: resetCodeVerified,
    );
  }

  factory ProfileUserModel.fromEntity(ProfileUserEntity entity) {
    return ProfileUserModel(
      id: entity.id,
      username: entity.username,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phone: entity.phone,
      isVerified: entity.isVerified,
      passwordResetCode: entity.passwordResetCode,
      passwordResetExpires: entity.passwordResetExpires,
      resetCodeVerified: entity.resetCodeVerified,
    );
  }

  // Factory constructor to convert JSON to ProfileUserModel
  factory ProfileUserModel.fromJson(Map<String, dynamic> json) {
    print("📢 Received JSON in fromJson: $json"); // Print data before decoding

    // Extract the 'user' object from the response
    var user = json["user"];
    print("📢 User Data: $user");

    // Now map the 'user' object to the ProfileUserModel fields
    return ProfileUserModel(
      id: user["_id"] ?? "",
      username: user["username"] ?? "",
      firstName: user["firstName"] ?? "",
      lastName: user["lastName"] ?? "",
      email: user["email"] ?? "",
      phone: user["phone"] ?? "",
      isVerified: user["isVerified"] is bool
          ? user["isVerified"] as bool
          : user["isVerified"] == "false",
      passwordResetCode: user["passwordResetCode"],
      passwordResetExpires: user["passwordResetExpires"],
      resetCodeVerified: user["resetCodeVerified"] is bool
          ? user["resetCodeVerified"] as bool
          : user["resetCodeVerified"] == "true",
    );
  }

  // Convert ProfileUserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "phone": phone,
      "passwordResetCode": passwordResetCode,
      "passwordResetExpires": passwordResetExpires,
      "resetCodeVerified": resetCodeVerified,
    };
  }
}
