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
import '../../presentation/Widgets/pop_up_item.dart';
import '../domain/model/location_area_model.dart';
import 'logic/pick_location_cubit.dart';
import 'logic/pick_location_states.dart';

/// model list pop up with search
showCityPopUp({
  required BuildContext context,
  required String title,
  required Function(LocationAreaModel) onApply,
  LocationAreaModel? preSelectedCity,
}) async {
  if(preSelectedCity !=null){
    PickLocationCubit.get(context).setSelectedCity(preSelectedCity);

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
                                hintKey: AppLocalizations.of(context)!.lblCity,
                                onChanged: (val) {
                                  pickLocationCtx
                                      .read<PickLocationCubit>()
                                      .searchInCityList(val!);

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
                                is CityLocationLoadingState) ...[
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
                                is CityLocationFailedState) ...[
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
                                  is CityLocationEmptyState) ...[
                                NoDataFoundWidget(
                                  imageString: "no_area_found.svg",
                                  title: AppLocalizations.of(context)!.lblCity,
                                  hint: AppLocalizations.of(context)!.lblCity,
                                  showButton: false,
                                )
                              ] else ...[
                                ///list of items
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: pickLocationCtx
                                      .read<PickLocationCubit>()
                                      .tempCityList
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
                                          onTap: (){
                                            pickLocationCtx
                                                .read<PickLocationCubit>()
                                                .setSelectedCity(pickLocationCtx
                                                .read<PickLocationCubit>()
                                                .tempCityList[index]);
                                          },
                                          child: PopUpItemWidget(
                                            isSelected:pickLocationCtx
                                                .read<PickLocationCubit>()
                                                .isThisCitySelected(pickLocationCtx
                                                .read<
                                                PickLocationCubit>()
                                                .tempCityList[index]),
                                            name: pickLocationCtx
                                                .read<PickLocationCubit>()
                                                .tempCityList[index]
                                                .name
                                                .toString() ,
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
                                .selectedCity !=
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
                              .selectedCity!);

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
