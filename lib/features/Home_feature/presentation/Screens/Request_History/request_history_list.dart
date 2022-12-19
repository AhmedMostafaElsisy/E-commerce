import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/Screens/Request_History/request_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../logic/request_cubit/request_cubit.dart';
import '../../logic/request_cubit/request_cubit_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RequestHistoryList extends StatefulWidget {
  const RequestHistoryList({Key? key}) : super(key: key);

  @override
  State<RequestHistoryList> createState() => _RequestHistoryListState();
}

class _RequestHistoryListState extends State<RequestHistoryList> {
  late RequestCubit requestCubit;

  @override
  void initState() {
    super.initState();
    requestCubit = BlocProvider.of<RequestCubit>(context);
    requestCubit.getRequestHistory();
    requestCubit.scrollController = ScrollController();
    requestCubit.scrollController.addListener(
          () {
            requestCubit.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppConstants.pagePadding),
        child: BlocConsumer<RequestCubit, RequestCubitState>(
          listener: (requestCtx, requestState) {
            if (requestState is RequestHistoryFailedState) {
              checkUserAuth(
                  context: requestCtx, errorType: requestState.error.type);
            }
          },
          builder: (requestCtx, requestState) {
            if (requestState is RequestHistoryLoadingState) {
              return const CommonLoadingWidget();
            } else if (requestState is RequestHistoryFailedState) {
              return CommonError(
                errorMassage: requestState.error.errorMassage,
                onTap: () {
                  requestCubit.getRequestHistory();
                },
                withButton: true,
              );
            } else if (requestState is RequestHistoryEmptyState) {
              return EmptyScreen(
                  imageString: "empty_list.svg",
                  titleKey: AppLocalizations.of(context)!.lblNoTripFound,
                  description:
                      AppLocalizations.of(context)!.lblNoTripFoundHomeDesc,
                  imageHeight: 56,
                  imageWidth: 56);
            } else {
              return Column(children: [
                Expanded(
                  child: RefreshIndicator(
                    color: AppConstants.mainColor,
                   onRefresh: ()=> requestCubit.getRequestHistory() ,
                    child: ListView.separated(
                        shrinkWrap: true,
                        controller: requestCubit.scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.only(
                            top: getWidgetHeight(10),
                            bottom: getWidgetHeight(10)),
                        itemBuilder: (context, index) {
                          if (index >=
                              requestCtx
                                  .read<RequestCubit>()
                                  .requestHistoryList
                                  .length &&
                              requestCtx
                                  .read<RequestCubit>()
                                  .hasMoreData) {
                            return const CommonLoadingWidget();
                          } else if (index >=
                              requestCtx
                                  .read<RequestCubit>()
                                  .requestHistoryList
                                  .length) {
                            return const SizedBox();
                          }else{
                            return  RequestHistoryItem(
                              model:  requestCtx
                                  .read<RequestCubit>()
                                  .requestHistoryList[index],
                            );
                          }

                        },
                        separatorBuilder: (context, index) {
                          return getSpaceHeight(AppConstants.pagePadding);
                        },
                        itemCount: requestCtx
                            .read<RequestCubit>()
                            .requestHistoryList
                            .length+1),
                  ),
                ),
              ]);
            }
          },
        ),
      ),
    );
  }
}
