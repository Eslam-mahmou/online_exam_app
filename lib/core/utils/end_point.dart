class EndPoints {
  static const String login="/api/v1/auth/signin";
  static const String forgetPassword="/api/v1/auth/forgotPassword";
  static const String verifyEmail="/api/v1/auth/verifyResetCode";
  static const String signUpDomain = "/api/v1/auth/signup";
  static const String resetPassword="/api/v1/auth/resetPassword";
  static const String editProfile = "/api/v1/auth/editProfile";
  static const String changePasswordDomain = "/api/v1/auth/changePassword";
  static const String getUser = "/api/v1/auth/profileData";
  static const String getAllSubject = "/api/v1/subjects";
  static const String getExam = "/api/v1/exams";
  static const String getQuestionOnExam = "/api/v1/questions";
  static const String checkAnswer = "/api/v1/questions/check";
}