import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/features/rating_feature/presentation/screen/rating_start_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../logic/rating_cubit.dart';
import '../logic/rating_cubit_states.dart';

Future<void> showReportSheet(
    {required BuildContext context, required int storeId}) async {
  TextEditingController commentController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RatingCubit.get(context).setRate(0);
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (_) => BlocConsumer<RatingCubit, RatingCubitStates>(
              listener: (rateCtx, rateState) {
            if (rateState is RatingSuccessStates) {
              Navigator.of(context).pop();
              showSnackBar(
                  context: rateCtx,
                  title: AppLocalizations.of(context)!.lblRateSuccess,
                  color: AppConstants.successColor);
            }
          }, builder: (rateCtx, rateState) {
            if (rateState is RatingFailedStates) {
              return CommonError(
                withButton: true,
                errorMassage: rateState.error.errorMassage,
                onTap: () {
                  // reportCtx.read<ReportCubit>().getReportReasons();
                },
              );
            } else {
              return GestureDetector(
                onTap: () => hideKeyboard(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                          vertical: getWidgetHeight(
                              AppConstants.pagePaddingDouble * 1.5),
                          horizontal:
                              getWidgetWidth(AppConstants.pagePadding)) +
                      EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                  child: Container(
                    width: double.infinity,
                    height: getWidgetHeight(325),
                    padding:   EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    decoration: BoxDecoration(
                      color: AppConstants.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonTitleText(
                              textKey:
                                  AppLocalizations.of(context)!.lblLeaveRate,
                              textFontSize: AppConstants.normalFontSize,
                              textWeight: FontWeight.w700,
                              textColor: AppConstants.mainColor,
                            ),
                            GestureDetector(
                                onTap: () {
                                  if(rateState is! RatingLoadingStates) {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const CommonAssetSvgImageWidget(
                                    imageString: "close.svg",
                                    height: 16,
                                    width: 16))
                          ],
                        ),
                        getSpaceHeight(AppConstants.pagePadding),
                        CommonTitleText(
                          textKey: AppLocalizations.of(context)!.lblSelectRate,
                          textFontSize: AppConstants.smallFontSize,
                          textWeight: FontWeight.w600,
                          textColor: AppConstants.lightBlackColor,
                        ),
                        getSpaceHeight(AppConstants.pagePadding),
                        commonRatingBarBuilder(
                          onRatingUpdate: (rating) {
                            rateCtx.read<RatingCubit>().setRate(rating.toInt());
                          },
                        ),
                        getSpaceHeight(AppConstants.pagePadding),
                        CommonTitleText(
                          textKey:
                              AppLocalizations.of(context)!.lblAddRateToHelp,
                          textFontSize: AppConstants.smallFontSize,
                          textWeight: FontWeight.w600,
                          textColor: AppConstants.lightBlackColor,
                        ),
                        getSpaceHeight(AppConstants.pagePadding),

                        Form(
                          key: formKey,
                          child: CommonTextFormField(
                            fieldHeight: 80,
                            minLines: 4,
                            maxLines: 20,
                            controller: commentController,
                            hintKey: AppLocalizations.of(context)!.lblWriteRate,
                            keyboardType: TextInputType.text,
                            labelHintColor: AppConstants.greyColor,
                            validator: (value){
                              if(value!.isEmpty){
                                return AppLocalizations.of(context)!.lblWriteRate;
                              }
                              return null;
                            },
                          ),
                        ),

                        ///spacer
                        getSpaceHeight(AppConstants.smallPadding),

                        /// Create Account Button
                        CommonGlobalButton(
                          height: 48,
                          buttonBackgroundColor: AppConstants.mainColor,
                          isLoading: rateState is RatingLoadingStates,
                          buttonTextSize: 18,
                          isEnable: rateCtx.read<RatingCubit>().currentRating!=0 ,
                          buttonTextFontWeight: FontWeight.w400,
                          buttonText: AppLocalizations.of(context)!.lblSend,
                          onPressedFunction: () {
                            if(formKey.currentState!.validate()){
                              rateCtx.read<RatingCubit>().addRating(
                                rate:  rateCtx.read<RatingCubit>().currentRating,
                                comment: commentController.text,
                                orderId: storeId
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }));
}
