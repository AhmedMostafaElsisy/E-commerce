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

  ///rating keys
  static const String ratingKey = "$userTypeKey/rate";

  ///Requests keys
  static const String requestListKey = "$userTypeKey/requests";
  static const String requestStoreKey = "$userTypeKey/requests/store";
  static const String requestStatesKey = "$userTypeKey/requests/changeStatus";
  static const String currentRequestKey =
      "$userTypeKey/requests/currentRequest";
  static const String findRequestKey = "$userTypeKey/requests/find";

  ///location key
  static const String locationListKey = "/general/places";

  ///Setting
  static const String settingKey = "/general/settings";

  ///Todo:check the endpoint when integrate with the api
  ///Favorite
  static const String favoriteKey = "/Favorite";

  ///Store
  static const String storeKey = "/Store";
  ///product
  static const String productKey = "/product";

}
