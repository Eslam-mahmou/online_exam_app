import 'package:equatable/equatable.dart';

class ProfileUserEntity extends Equatable {
  final String id;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final String? passwordResetCode;
  final String? passwordResetExpires;
  final bool? resetCodeVerified;

  const ProfileUserEntity({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        phone,
        role,
        passwordResetCode,
        passwordResetExpires,
        resetCodeVerified,
      ];
}
