import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_loading_widget.dart';
import 'package:captien_omda_customer/features/rating_feature/presentation/screen/widgets/rating_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../logic/rating_cubit.dart';
import '../logic/rating_cubit_states.dart';

class RatingListScreen extends StatefulWidget {
  const RatingListScreen({Key? key}) : super(key: key);

  @override
  State<RatingListScreen> createState() => _RatingListScreenState();
}

class _RatingListScreenState extends State<RatingListScreen> {
  late RatingCubit ratingCubit;

  @override
  void initState() {
    super.initState();
    ratingCubit = BlocProvider.of<RatingCubit>(context);
    ratingCubit.getRatingListListData();
    ratingCubit.scrollController = ScrollController();
    ratingCubit.scrollController.addListener(
      () {
        ratingCubit.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      body: MainAppPage(
        screenContent: Column(children: [
          CommonAppBar(
            withBack: true,
            appBarBackGroundColor: AppConstants.transparent,
            showBottomIcon: false,
            centerTitle: false,
            titleWidget: CommonTitleText(
              textKey: AppLocalizations.of(context)!.lblRatings,
              textColor: AppConstants.lightBlackColor,
              textWeight: FontWeight.w400,
              textFontSize: AppConstants.normalFontSize,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getWidgetWidth(AppConstants.pagePadding)),
            child: Column(
              children: [
                BlocConsumer<RatingCubit, RatingCubitStates>(
                  listener: (ratingCtx, ratingState) {
                    if (ratingState is RatingListFailedStates) {
                      checkUserAuth(
                          context: ratingCtx,
                          errorType: ratingState.error.type);
                    }
                  },
                  builder: (ratingCtx, ratingState) {
                    if (ratingState is RatingListLoadingStates) {
                      return const CommonLoadingWidget();
                    } else if (ratingState is RatingListFailedStates) {
                      return CommonError(
                        errorMassage: ratingState.error.errorMassage,
                        withButton: true,
                        onTap: () => ratingCubit.getRatingListListData(),
                      );
                    } else if (ratingCtx
                        .read<RatingCubit>()
                        .storeRatingList
                        .isNotEmpty) {
                      return EmptyScreen(
                          imageString: "category.svg",
                          titleKey:
                              AppLocalizations.of(context)!.lblNoRatingFound,
                          imageHeight: 80,
                          imageWidth: 08);
                    } else {
                      return SizedBox(
                        height: SharedText.screenHeight - 110,
                        child: Column(
                          children: [
                            Expanded(
                                child: ListView.separated(
                                  shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    controller:  ratingCubit.scrollController,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return RatingItemList(
                                        model: ratingCtx
                                            .read<RatingCubit>()
                                            .storeRatingList[0],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return getSpaceHeight(
                                          AppConstants.pagePadding);
                                    },
                                    itemCount: ratingCtx
                                        .read<RatingCubit>()
                                        .storeRatingList
                                        .length)),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
