import 'package:default_repo_app/Logic/Models/user_base_model.dart';

import 'Responsive_UI/device_info.dart';

class SharedText {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double hPadding = 10.0;
  static double vPadding = 10.0;
  static UserBaseModel? currentUser;

  static DeviceInfo? deviceType;

  static String currentLocale = 'en';
  static String userToken = '';

  static const double globalBorderRadius = 8.0;

  static bool isSecond = false;

  static String? branchName;
  static int? branchId;
  static String? reservationDate;

  /// On_Will_Pop app close time
  static DateTime? currentBackPressTime;
}
