import 'package:default_repo_app/Logic/Models/user_base_model.dart';

import 'Responsive_UI/device_info.dart';

class SharedText {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static UserBaseModel? currentUser;

  static DeviceInfo? deviceType;

  static String currentLocale = 'en';
  static String userToken = '';

  /// On_Will_Pop app close time
  static DateTime? currentBackPressTime;
}
