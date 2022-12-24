import 'package:captien_omda_customer/core/Helpers/Extensions/prevent_string_spacing.dart';
import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/features/rating_feature/presentation/logic/rating_cubit.dart';
import 'package:captien_omda_customer/features/rating_feature/presentation/screen/rating_start_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import '../logic/rating_cubit_states.dart';

class RatingScreen extends StatefulWidget {
  final RouteArgument routeArgument;

  const RatingScreen({Key? key, required this.routeArgument}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double currentRating = 0.0;
  late TextEditingController ratingController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    ratingController= TextEditingController();
  }
  @override
  void dispose() {
    ratingController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        withNotification: false,
        showBottomIcon: false,
        withBack: false,
        showLeadingWidget: true,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblRating,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w700,
          textFontSize: AppConstants.normalFontSize,
        ),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context)
              .requestFocus(FocusNode());
        },
        child: Column(children: [

          ///Spacer
          getSpaceHeight(20),

          ///Rating image
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonAssetSvgImageWidget(
                imageString: "rate_icon.svg",
                height: 205,
                width: SharedText.screenWidth-60,
                fit: BoxFit.contain,
              ),
            ],
          ),

          ///Spacer
          getSpaceHeight(25),
          Container(
            width: SharedText.screenWidth,
            height: getWidgetHeight(478),
            decoration: BoxDecoration(
                color: AppConstants.lightWhiteColor,
                boxShadow: [
                  BoxShadow(
                      color: AppConstants.lightBlackColor.withOpacity(0.2),
                      blurRadius: 10.0,
                      offset: const Offset(0, 1))
                ],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppConstants.borderRadius),
                  topLeft: Radius.circular(AppConstants.borderRadius),
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidgetHeight(AppConstants.pagePadding),
                  vertical: getWidgetWidth(AppConstants.pagePadding)) +
                  EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                child: BlocConsumer<RatingCubit, RatingCubitStates>(
                  listener: (ratingCtx, ratingState) {
                    if(ratingState is RatingSuccessStates){
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        RouteNames.mainBottomNavPageRoute,
                            (route) => false,
                      );
                      BlocProvider.of<BottomNavCubit>(context).selectItem(0);
                    }else if (ratingState is RatingFailedStates){
                      checkUserAuth(
                          context: ratingCtx, errorType: ratingState.error.type);
                      showSnackBar(
                        context: ratingCtx,
                        title: ratingState.error.errorMassage!,
                      );
                    }
                  },
                  builder: (ratingCtx, ratingState) {
                    return Form(
                      key: formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            ///total
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!.lblTotal,
                              textColor: AppConstants.lightBlackColor,
                              textWeight: FontWeight.w700,
                              textFontSize: AppConstants.normalFontSize,
                            ),

                            ///spacer
                            getSpaceHeight(AppConstants.pagePadding),

                            ///trip price
                            CommonTitleText(
                              textKey:
                              "${widget.routeArgument.requestModel!
                                  .price!} ${AppLocalizations.of(context)!.lblEGP}",
                              textColor: AppConstants.lightBorderColor,
                              textWeight: FontWeight.w700,
                              textFontSize: AppConstants.titleFontSize,
                            ),

                            ///spacer
                            getSpaceHeight(AppConstants.pagePadding),

                            ///spacer
                            const Divider(
                              color: AppConstants.lightGrayColor,
                              thickness: 1,
                            ),

                            ///spacer
                            getSpaceHeight(AppConstants.pagePadding),

                            ///add rating title
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!.lblAddRating,
                              textColor: AppConstants.lightBlackColor,
                              textWeight: FontWeight.w700,
                              textFontSize: AppConstants.normalFontSize,
                            ),

                            ///spacer
                            getSpaceHeight(AppConstants.pagePadding),

                            ///how was driver
                            CommonTitleText(
                              textKey:
                              "${AppLocalizations.of(context)!.lblHowWas} ${widget
                                  .routeArgument.requestModel!.driverModel!.name!
                                  .getStringWithoutSpacings()} ؟ ",
                              textColor: AppConstants.lightRedColor,
                              textWeight: FontWeight.w600,
                              textFontSize: AppConstants.normalFontSize,
                            ),

                            ///spacer
                            getSpaceHeight(AppConstants.pagePadding),

                            ///rating
                            commonRatingBarBuilder(
                              onRatingUpdate: (rating) {
                                setState(() {
                                  currentRating = rating;
                                });
                              },
                            ),

                            ///spacer
                            getSpaceHeight(AppConstants.pagePadding),
                            CommonTextFormField(
                              controller: ratingController,
                              radius: AppConstants.smallBorderRadius * 2,
                              filledColor: AppConstants.backGroundColor,
                              hintKey:currentRating <=3?AppLocalizations.of(context)!
                                  .lblAddRate :
                              "${AppLocalizations.of(context)!
                                  .lblAddRate} (${AppLocalizations.of(context)!
                                  .lblOption})",
                              keyboardType: TextInputType.emailAddress,
                              labelHintStyle: AppConstants.mainTextColor,
                              contentPaddingHorizontal: getWidgetWidth(16),
                              contentPaddingVertical: getWidgetHeight(12),
                              withSuffixIcon: false,
                              maxLines: 5,
                              minLines: 5,
                              validator: (value) {
                                if (value!.isEmpty &(currentRating <=3)) {
                                  return AppLocalizations.of(context)!
                                      .lblRatingError;
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() {});
                                return null;
                              },
                            ),

                            ///spacer
                            getSpaceHeight(AppConstants.pagePadding),

                            ///send rating
                            CommonGlobalButton(
                              height: 48,
                              buttonBackgroundColor: AppConstants.mainColor,
                              isEnable: currentRating != 0.0,
                              isLoading: ratingState is RatingLoadingStates,
                              buttonTextSize: AppConstants.normalFontSize,
                              buttonTextFontWeight: FontWeight.w700,
                              buttonText: AppLocalizations.of(context)!.lblSend,
                              onPressedFunction: () {
                               if(formKey.currentState!.validate()){
                                 FocusScope.of(context)
                                     .requestFocus(FocusNode());
                                 ratingCtx.read<RatingCubit>().addRating(
                                     driverId: widget.routeArgument.requestModel!
                                         .driverModel!.id!,
                                     requestId: widget.routeArgument.requestModel!
                                         .id!,
                                     rate: currentRating.toInt(),
                                     comment: ratingController.text);
                               }
                              },
                            ),

                            ///spacer
                            getSpaceHeight(AppConstants.smallPadding),

                            ///cancel
                            CommonGlobalButton(
                              height: 48,
                              buttonBackgroundColor: AppConstants.lightWhiteColor,
                              buttonTextColor: AppConstants.mainTextColor,
                              showBorder: false,
                              buttonTextSize: AppConstants.normalFontSize,
                              buttonTextFontWeight: FontWeight.w700,
                              buttonText: AppLocalizations.of(context)!.lblCancel,
                              shadowBackgroundColor: AppConstants.lightWhiteColor,
                              elevation: 0,
                              onPressedFunction: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ]),
                    );
                  },
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
