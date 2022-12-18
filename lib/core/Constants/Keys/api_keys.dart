class ApiKeys {
  /// user type key
  static const String userTypeKey = "/customer";

  ///Auth Keys
  static const String loginKey = "$userTypeKey/login";
  static const String singUpKey = "$userTypeKey/register";
  static const String logOutKey = "$userTypeKey/logout";

  ///profile keys
  static const String profileKey = "$userTypeKey/profile";
  static const String updateProfileKey = "$userTypeKey/updateProfile";
  static const String deleteProfileKey = "$userTypeKey/delete";

  ///Password keys
  static const String changePasswordKey = "$userTypeKey/changePassword";
  static const String forgetPasswordKey = "$userTypeKey/forgetPassword";
  static const String resetPasswordKey = "$userTypeKey/resetPassword";

  ///Otp Keys
  static const String checkAndVerifyKey = "$userTypeKey/register-verify";
  static const String checkOtpKey = "$userTypeKey/otp-check";
  static const String reSendOtpKey = "$userTypeKey/resend-otp";

  ///notification keys
  static const String notificationKey = "/notifications";
  static const String clearNotificationKey = "$notificationKey/clear";
  static const String toggleNotificationKey = "$notificationKey/toggle";
  static const String readNotificationKey = "/read";

  ///Setting keys
  static const String termsKey = "/terms";
  static const String faqKey = "/faqs";
  ///Requests keys
  static const String requestListKey = "$userTypeKey/requests";
  ///location key
  static const String locationListKey = "/general/places";

}
