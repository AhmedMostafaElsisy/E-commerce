import '../../../Data/Interfaces/notification_interface.dart';
import '../../../Data/Models/notification_model.dart';
import '../../../core/Constants/Enums/exception_enums.dart';
import 'notification_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/Error_Handling/custom_error.dart';

class NotificationCubit extends Cubit<NotificationStates> {
  NotificationCubit(this._repo) : super(NotificationStateInit());

  static NotificationCubit get(context) => BlocProvider.of(context);

  final NotificationListRepositoryInterface _repo;

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  List<NotificationModel> notificationList = [];
  bool hasMoreData = false;

  Future onRefresh() async {
    // currentUserOffers.clear();
    await getNotificationList();
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! NotificationLoadingMoreDateState && hasMoreData) {
        whenScrollNotificationPagination();
      }
    }
  }

  /// Pagination Function
  whenScrollNotificationPagination() async {
    page = page + 1;

    try {
      emit(NotificationLoadingMoreDateState());
      var result = await _repo.getNotificationList(page: page);
      if (_repo.isError) {
        hasMoreData = false;
        emit(NotificationErrorMoreDateState(
          error: _repo.errorMsg,
        ));
      } else {
        var tempList = notificationListFromJson(result.data["data"]);
        hasMoreData = tempList.length == 10;
        notificationList.addAll(tempList);
        emit(NotificationSuccessMoreDateState());
      }
    } catch (e) {
      hasMoreData = false;
      emit(
        NotificationErrorMoreDateState(
          error: CustomError(
            type: CustomStatusCodeErrorType.unExcepted,
            errorMassage: e.toString(),
          ),
        ),
      );
    }
  }

  /// Get All notification List
  getNotificationList() async {
    emit(NotificationLoadingState());
    try {
      page = 1;
      var result = await _repo.getNotificationList(page: page);
      if (_repo.isError) {
        emit(NotificationErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        notificationList = notificationListFromJson(result.data);
        hasMoreData = notificationList.length == 10;
        if (notificationList.isEmpty) {
          emit(NotificationEmptyState());
        } else {
          emit(NotificationSuccessState());
        }
      }
    } catch (e) {
      emit(NotificationErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  /// clear All notification List
  clearAllNotificationList() async {
    emit(NotificationLoadingState());
    try {
      await _repo.clearAllNotification();
      if (_repo.isError) {
        emit(NotificationErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        emit(ClearNotificationSuccessState());
      }
    } catch (e) {
      emit(NotificationErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  /// mark notification as read
  readNotification({required int notificationId}) async {
    emit(NotificationLoadingState());
    try {
      await _repo.markNotificationAsRead(notificationId: notificationId);
      if (_repo.isError) {
        emit(NotificationErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        emit(ReadNotificationSuccessState());
      }
    } catch (e) {
      emit(ReadNotificationErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }

  ///Enable or disable notification
  enableOrDisableNotification({required bool enable}) async {
    emit(EnableOrDisableNotificationLoadingState());
    try {
      await _repo.stopOrPauseNotification(state: enable);
      if (_repo.isError) {
        emit(EnableOrDisableNotificationErrorState(
          error: _repo.errorMsg,
        ));
      } else {
        emit(EnableOrDisableNotificationSuccessState());
      }
    } catch (e) {
      emit(EnableOrDisableNotificationErrorState(
          error: CustomError(
              type: CustomStatusCodeErrorType.unExcepted,
              errorMassage: e.toString())));
    }
  }
}
