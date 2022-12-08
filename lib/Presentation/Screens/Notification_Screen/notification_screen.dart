import 'package:captien_omda_customer/Logic/Bloc_Cubits/Notification_Cubit/notification_cubit.dart';
import 'package:captien_omda_customer/Logic/Bloc_Cubits/Notification_Cubit/notification_states.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_app_bar_widget.dart';
import 'package:captien_omda_customer/Presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../Widgets/common_empty_widget.dart';
import '../../Widgets/common_error_widget.dart';
import '../../Widgets/common_loading_widget.dart';
import 'notification_item.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  State<NotificationListScreen> createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  late NotificationCubit notificationCubit;

  @override
  void initState() {
    super.initState();
    notificationCubit = BlocProvider.of<NotificationCubit>(context);
    notificationCubit.scrollController = ScrollController();
    notificationCubit.getNotificationList();
    notificationCubit.scrollController.addListener(
      () {
        notificationCubit.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
        centerTitle: false,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblNotification,
          textFontSize: AppConstants.largeFontSize,
          textWeight: FontWeight.w500,
          textColor: AppConstants.lightBlackColor,
          textAlignment: TextAlign.start,
        ),
        withBack: true,
        withNotification: false,
        showBottomIcon: false,
        customActionWidget: Center(
          child: InkWell(
              onTap: () {
                notificationCubit.clearAllNotificationList();
              },
              child: CommonTitleText(
                textKey: AppLocalizations.of(context)!.lblClearAll,
                textWeight: FontWeight.w400,
                textFontSize: AppConstants.normalFontSize,
                textColor: AppConstants.mainColor,
              )),
        ),
      ),
      body: BlocConsumer<NotificationCubit, NotificationStates>(
          listener: (notificationCtx, notificationState) {
        if (notificationState is NotificationErrorState) {
          checkUserAuth(
              context: notificationCtx,
              errorType: notificationState.error!.type);
        } else if (notificationState is ClearNotificationSuccessState) {
          notificationCubit.getNotificationList();
        } else if (notificationState is ReadNotificationSuccessState) {
          notificationCubit.getNotificationList();
        }
      }, builder: (notificationCtx, notificationState) {
        if (notificationState is NotificationErrorState) {
          return CommonError(
            errorMassage: notificationState.error?.errorMassage,
            withButton: true,
            onTap: () => notificationCubit.getNotificationList(),
          );
        } else if (notificationState is NotificationEmptyState) {
          return EmptyScreen(
            imageString: "notification_empty.svg",
            imageWidth: 80,
            imageHeight: 80,
            titleKey: AppLocalizations.of(context)!.lblNoNotification,
            description:
                AppLocalizations.of(context)!.lblNoNotificationDescription,
            withButton: false,
          );
        } else if (notificationState is NotificationLoadingState) {
          return const CommonLoadingWidget();
        } else {
          return ListView.separated(
            padding: EdgeInsets.symmetric(vertical: getWidgetHeight(16)),
            shrinkWrap: true,
            controller: notificationCubit.scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: notificationCtx
                    .read<NotificationCubit>()
                    .notificationList
                    .length +
                1,
            separatorBuilder: (context, index) {
              return getSpaceHeight(4);
            },
            itemBuilder: (context, index) {
              if (index >=
                      notificationCtx
                          .read<NotificationCubit>()
                          .notificationList
                          .length &&
                  notificationCtx.read<NotificationCubit>().hasMoreData) {
                return const CommonLoadingWidget();
              } else if (index >=
                  notificationCtx
                      .read<NotificationCubit>()
                      .notificationList
                      .length) {
                return const SizedBox();
              } else {
                return InkWell(
                  onTap: () {
                    notificationCubit.readNotification(
                        notificationId: notificationCtx
                            .read<NotificationCubit>()
                            .notificationList[index]
                            .id!);
                  },
                  child: NotificationItem(
                    model: notificationCtx
                        .read<NotificationCubit>()
                        .notificationList[index],
                  ),
                );
              }
            },
          );
        }
      }),
    );
  }
}
