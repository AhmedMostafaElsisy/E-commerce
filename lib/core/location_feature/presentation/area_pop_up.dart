import 'package:captien_omda_customer/core/location_feature/presentation/widget/data_empty_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../Constants/app_constants.dart';
import '../../Helpers/shared.dart';
import '../../presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../presentation/Widgets/common_error_widget.dart';
import '../../presentation/Widgets/common_global_button.dart';
import '../../presentation/Widgets/common_text_form_field_widget.dart';
import '../../presentation/Widgets/common_title_text.dart';
import '../domain/model/location_area_model.dart';
import 'logic/pick_location_cubit.dart';
import 'logic/pick_location_states.dart';

/// model list pop up with search
showAreaPopUp({
  required BuildContext context,
  required String title,
  required Function(LocationAreaModel) onApply,
  LocationAreaModel? preSelectedCity,
}) async {
  if(preSelectedCity !=null){
    PickLocationCubit.get(context).setSelectedArea(preSelectedCity);

  }
  return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return BlocConsumer<PickLocationCubit, PickLocationStates>(
            listener: (pickLocationCtx, pickLocationState) {},
            builder: (pickLocationCtx, pickLocationState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: const EdgeInsets.all(AppConstants.pagePadding),
                  color: AppConstants.lightWhiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// close button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonTitleText(
                            textKey: title,
                            textWeight: FontWeight.w400,
                            textFontSize: AppConstants.smallFontSize,
                            textColor: AppConstants.mainColor,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const CommonAssetSvgImageWidget(
                                  imageString: "close.svg",
                                  height: 16,
                                  width: 16))
                        ],
                      ),

                      ///spacer
                      getSpaceHeight(20),

                      ///list
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            /// Search filed
                            CommonTextFormField(
                                hintKey: AppLocalizations.of(context)!.lblArea,
                                onChanged: (val) {
                                  pickLocationCtx
                                      .read<PickLocationCubit>()
                                      .searchInAreaList(val!);

                                  return;
                                },
                                withSuffixIcon: true,
                                keyboardType: TextInputType.text,
                                radius: AppConstants.smallRadius,
                                prefixIcon: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 15),
                                    child: const CommonAssetSvgImageWidget(
                                        imageString: "search.svg",
                                        height: 16,
                                        width: 16,
                                        fit: BoxFit.fill))),

                            /// Space
                            getSpaceHeight(16),

                            if (pickLocationState
                            is AreaLocationLoadingState) ...[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircularProgressIndicator(
                                        color: AppConstants.mainColor),
                                  ),
                                ],
                              ),
                            ] else if (pickLocationState
                            is AreaLocationFailedState) ...[
                              CommonError(
                                onTap: () {
                                  pickLocationCtx
                                      .read<PickLocationCubit>()
                                      .getCityData();
                                },
                                withButton: true,
                                errorMassage:
                                pickLocationState.error.errorMassage,
                              )
                            ] else ...[
                              if (pickLocationState
                              is AreaLocationEmptyState) ...[
                                NoDataFoundWidget(
                                  imageString: "no_area_found.svg",
                                  title: AppLocalizations.of(context)!.lblArea,
                                  hint: AppLocalizations.of(context)!.lblArea,
                                  showButton: false,
                                )
                              ] else ...[
                                ///list of items
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: pickLocationCtx
                                      .read<PickLocationCubit>()
                                      .tempAreaList
                                      .length,
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 4.0,
                                    childAspectRatio: 4.0,
                                    mainAxisSpacing: 4.0,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        pickLocationCtx
                                            .read<PickLocationCubit>()
                                            .setSelectedArea(pickLocationCtx
                                            .read<PickLocationCubit>()
                                            .tempAreaList[index]);
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(pickLocationCtx
                                                .read<PickLocationCubit>()
                                                .isThisAreaSelected(pickLocationCtx
                                                .read<
                                                PickLocationCubit>()
                                                .tempAreaList[index])
                                                ? 1
                                                : 0),
                                            width: getWidgetWidth(16),
                                            height: getWidgetHeight(16),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: pickLocationCtx
                                                      .read<PickLocationCubit>()
                                                      .isThisAreaSelected(pickLocationCtx
                                                      .read<
                                                      PickLocationCubit>()
                                                      .tempAreaList[index])
                                                      ? AppConstants.mainColor
                                                      : Colors.transparent,
                                                ),
                                                shape: BoxShape.circle),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color:pickLocationCtx
                                                      .read<PickLocationCubit>()
                                                      .isThisAreaSelected(pickLocationCtx
                                                      .read<
                                                      PickLocationCubit>()
                                                      .tempAreaList[index])
                                                      ? AppConstants.mainColor
                                                      : Colors.transparent,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: AppConstants
                                                          .mainColor)),
                                            ),
                                          ),

                                          /// Spacer
                                          getSpaceWidth(4),

                                          Expanded(
                                            child: CommonTitleText(
                                              textAlignment: TextAlign.start,
                                              lines: 2,
                                              textOverflow:
                                              TextOverflow.ellipsis,
                                              textKey: pickLocationCtx
                                                  .read<PickLocationCubit>()
                                                  .tempAreaList[index]
                                                  .name
                                                  .toString(),
                                              textWeight: FontWeight.w400,
                                              textFontSize:
                                              AppConstants.smallFontSize,
                                              minTextFontSize:
                                              AppConstants.smallFontSize,
                                              textColor:
                                              AppConstants.mainTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ]
                            ],
                          ],
                        ),
                      ),
                      getSpaceHeight(20),
                      CommonGlobalButton(
                        height: 48,
                        buttonBackgroundColor: AppConstants.mainColor,
                        isEnable: pickLocationCtx
                            .read<PickLocationCubit>()
                            .selectedArea !=
                            null,
                        isLoading:
                        pickLocationState is CityLocationLoadingState,
                        radius: AppConstants.smallBorderRadius,
                        buttonTextSize: 18,
                        buttonTextFontWeight: FontWeight.w400,
                        buttonText: AppLocalizations.of(context)!.lblConfirm,
                        onPressedFunction: () {
                          onApply(pickLocationCtx
                              .read<PickLocationCubit>()
                              .selectedArea!);

                          Navigator.pop(context);
                        },
                        withIcon: false,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
