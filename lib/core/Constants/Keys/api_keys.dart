class ApiKeys {
  /// user type key
  static const String userTypeKey = "";

  ///Auth Keys
  static const String loginKey = "$userTypeKey/login-api";
  static const String singUpKey = "$userTypeKey/register-api";
  static const String logOutKey = "$userTypeKey/logout-api";

  ///profile keys
  static const String profileKey = "$userTypeKey/profile-api";
  static const String updateProfileKey = "$userTypeKey/update-profile-api";
  static const String deleteProfileKey = "$userTypeKey/delete-api";

  ///Password keys
  static const String changePasswordKey = "$userTypeKey/change-password-api";
  static const String forgetPasswordKey = "$userTypeKey/forget-api";
  static const String resetPasswordKey = "$userTypeKey/reset-password-api";

  ///Otp Keys
  static const String checkAndVerifyKey = "$userTypeKey/verify-otp-api";
  static const String checkOtpKey = "$userTypeKey/otp-check";
  static const String reSendOtpKey = "$userTypeKey/resend-otp-api";

  ///notification keys
  static const String notificationKey = "/notifications";
  static const String clearNotificationKey = "$notificationKey/clear";
  static const String toggleNotificationKey = "$notificationKey/toggle";
  static const String readNotificationKey = "/read";

  ///Setting keys
  static const String termsKey = "/terms";
  static const String faqKey = "/faqs";

  ///rating keys
  static const String ratingKey = "$userTypeKey/rate-store";

  ///Requests keys
  static const String requestListKey = "$userTypeKey/requests";
  static const String requestStoreKey = "$userTypeKey/requests/store";
  static const String requestStatesKey = "$userTypeKey/requests/changeStatus";
  static const String currentRequestKey =
      "$userTypeKey/requests/currentRequest";
  static const String findRequestKey = "$userTypeKey/requests/find";

  ///location key
  static const String locationListKey = "/general/places";

  ///location key
  static const String cityListKey = "/cities";

  static const String areaListKey = "/areas";

  ///Setting
  static const String settingKey = "/general/settings";

  ///Favorite
  static const String favoriteKey = "/fav-products";
  static const String addFavoriteKey = "/add-fav-product";
  static const String removeFavoriteKey = "/remove-fav-product";

  ///Store
  static const String storeKey = "/Store";
  static const String myStoreListKey = "/get-my-stores";
  static const String addStoreKey = "/add-store";
  static const String updateStoreKey = "/update-store";
  static const String showStoreKey = "/show-store";
  static const String storeProductsKey = "/store-products";

  static const String homeStoresKey = "/home-stores";

  ///product
  static const String productKey = "/product";
  static const String showProductKey = "/show-product";
  static const String productOfStoreKey = "/store-products";
  static const String addProductKey = "/add-product";
  static const String deleteProductKey = "/delete-product";
  static const String homeAdds = "/home-ads";
  static const String generalProduct = "/home-products";
  static const String productOnEditKey = "/product-on-edit";
  static const String productUpdateKey = "/update-product";

  ///category
  static const String categoryKey = "/home-categories";

  ///Tags
  static const String tagsKey = "/home-tags";

  ///plans
  static const String plansKey = "/plans";

  ///form
  static const String categoryFormKey = "/form-category";

  ///Order
  static const String orderListKey = "/get-orders";
  static const String showOrderKey = "/show-order";

  ///cart
  static const String getCartList = "/cart-products";
  static const String editProductQuantity = "/add-product-to-cart";
  static const String removeProductFromCart = "/remove-product-from-cart";

  ///checkout
  static const String createOrder = "/add-order";

  ///Contact
  static const String contactKey = "/contacts";
}
