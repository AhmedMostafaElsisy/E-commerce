import '../../core/model/base_model.dart';
import '../../core/Base_interface/base_interface.dart';

abstract class NotificationListRepositoryInterface extends BaseInterface {
  Future<BaseModel> getNotificationList({required int page});

  Future<BaseModel> clearAllNotification();
  Future<BaseModel> markNotificationAsRead({required int notificationId});

  Future<BaseModel> stopOrPauseNotification({required bool state});
}
