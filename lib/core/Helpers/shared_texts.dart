import 'dart:async';

import '../../features/Auth_feature/Domain/entities/base_user_entity.dart';
import '../../features/Chat_Feature/Data/chat_models/chat_user_model.dart';
import '../model/filter_collection_model.dart';
import 'Responsive_UI/device_info.dart';

class SharedText {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static UserBaseEntity? currentUser;
  static FilterCollectionModel filterModel = FilterCollectionModel(
    tags: [],
    categories: [],
  );

  static ChatUserModel? currentUserOfChat;
  static Timer? currentTimerOfSocket;

  static DeviceInfo? deviceType;

  static String currentLocale = 'en';
  static String userToken = '';
  static String deviceToken = 'asdasdasdads';

  /// On_Will_Pop app close time
  static DateTime? currentBackPressTime;

  static bool isAppLocalAr() {
    return currentLocale == "ar";
  }
}
