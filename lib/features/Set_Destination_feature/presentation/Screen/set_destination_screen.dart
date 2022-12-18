import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_loading_widget.dart';
import 'package:captien_omda_customer/features/Set_Destination_feature/presentation/logic/destination_cubit.dart';
import 'package:captien_omda_customer/features/Set_Destination_feature/presentation/logic/destination_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../logic/destination_event.dart';
import 'location_item_widget.dart';

class SetDestinationScreen extends StatefulWidget {
  const SetDestinationScreen({Key? key}) : super(key: key);

  @override
  State<SetDestinationScreen> createState() => _SetDestinationScreenState();
}

class _SetDestinationScreenState extends State<SetDestinationScreen> {
  late TextEditingController destinationFromController;

  late TextEditingController destinationToController;
  bool isDestinationFromSelected = true;
  late DestinationCubit destinationCubit;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    destinationFromController = TextEditingController();
    destinationToController = TextEditingController();
    destinationCubit = BlocProvider.of<DestinationCubit>(context);
    destinationCubit.clearData();
  }

  @override
  void dispose() {
    destinationToController.dispose();
    destinationFromController.dispose();
    destinationCubit.clearData();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.lightWhiteColor,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
        withBack: true,
        showBottomIcon: false,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblSetDestination,
          textColor: AppConstants.lightBlackColor,
          textWeight: FontWeight.w700,
          textFontSize: AppConstants.normalFontSize,
        ),
      ),
      body: BlocConsumer<DestinationCubit, DestinationStates>(
        listener: (destinationCtx, destinationState) {
          if (destinationState is DestinationFailedState) {
            checkUserAuth(
                context: destinationCtx,
                errorType: destinationState.error.type);
          } else if (destinationState is SetDestinationState) {
            if (isDestinationFromSelected) {
              destinationFromController.text = destinationCtx
                  .read<DestinationCubit>()
                  .destinationFrom!
                  .locationName!;
            } else {
              destinationToController.text = destinationCtx
                  .read<DestinationCubit>()
                  .destinationTo!
                  .locationName!;
            }
          } else if (destinationState is DestinationNotValidState) {
            showSnackBar(
              context: destinationCtx,
              title: AppLocalizations.of(context)!.lblLocationError,
            );
          }
        },
        builder: (destinationCtx, destinationState) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getWidgetWidth(AppConstants.pagePadding)),
                child: Form(
                  key: formKey,
                  child: Column(children: [
                    ///Spacer
                    getSpaceHeight(30),

                    ///from location
                    CommonTextFormField(
                      controller: destinationFromController,
                      radius: AppConstants.smallBorderRadius,
                      hintKey: AppLocalizations.of(context)!.lblCurrentLocation,
                      keyboardType: TextInputType.text,
                      labelHintStyle: AppConstants.mainTextColor,
                      withSuffixIcon: true,
                      blurRadius: 10,
                      shadowColor: AppConstants.lightBlackColor,
                      shadowOffset: const Offset(0, 1),
                      suffixIcon: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CommonAssetSvgImageWidget(
                            imageString: "location_to_icon.svg",
                            fit: BoxFit.contain,
                            height: 22,
                            width: 22),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return  AppLocalizations.of(context)!.lblLocationValidationMassage;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        isDestinationFromSelected = true;

                        destinationCtx
                            .read<DestinationCubit>()
                            .add(SearchClickEvent(value));
                        return null;
                      },
                    ),

                    ///spacer
                    getSpaceHeight(24),

                    ///to location
                    CommonTextFormField(
                      controller: destinationToController,
                      radius: AppConstants.smallBorderRadius,
                      hintKey:
                          AppLocalizations.of(context)!.lblDestinationLocation,
                      keyboardType: TextInputType.text,
                      labelHintStyle: AppConstants.mainTextColor,
                      blurRadius: 10,
                      shadowColor: AppConstants.lightBlackColor,
                      shadowOffset: const Offset(0, 1),
                      withSuffixIcon: true,
                      suffixIcon: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CommonAssetSvgImageWidget(
                            imageString: "location_from_icon.svg",
                            fit: BoxFit.contain,
                            height: 22,
                            width: 22),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return  AppLocalizations.of(context)!.lblLocationValidationMassage;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        isDestinationFromSelected = false;
                        destinationCtx
                            .read<DestinationCubit>()
                            .add(SearchClickEvent(value));
                        return null;
                      },
                    ),

                    ///spacer
                    getSpaceHeight(24),
                  ]),
                ),
              ),

              ///Divider
              Container(
                width: SharedText.screenWidth,
                height: getWidgetHeight(10),
                color: AppConstants.lightButtonGrayColor,
              ),
              if (destinationState is DestinationLoadingState) ...[
                getSpaceHeight(80),
                const CommonLoadingWidget(),
              ] else if (destinationState is DestinationEmptyState ||
                  destinationCtx
                      .read<DestinationCubit>()
                      .locationList
                      .isEmpty) ...[
                getSpaceHeight(32),
                EmptyScreen(
                  imageWidth: 250,
                  imageHeight: 200,
                  imageString: "empty_search_icon.svg",
                  titleKey: AppLocalizations.of(context)!.lblNoResultFound,
                  description:
                      AppLocalizations.of(context)!.lblLocationSearchDesc,
                ),
              ] else if (destinationState is DestinationFailedState) ...[
                CommonError(
                  errorMassage: destinationState.error.errorMassage,
                )
              ] else ...[
                ///location list
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidgetWidth(AppConstants.pagePadding)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  vertical: getWidgetHeight(15),
                                  horizontal: getWidgetWidth(3)),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    destinationCtx.read<DestinationCubit>().add(
                                        SetDestinationEvent(
                                            destinationCtx
                                                .read<DestinationCubit>()
                                                .locationList[index],
                                            isDestinationFromSelected));
                                  },
                                  child: LocationItemWidget(
                                    imagePath: isDestinationFromSelected
                                        ? "current_location_icon.svg"
                                        : "location_icon.svg",
                                    mainTitle: destinationCtx
                                        .read<DestinationCubit>()
                                        .locationList[index]
                                        .locationName!,
                                    subTitle: destinationCtx
                                        .read<DestinationCubit>()
                                        .locationList[index]
                                        .locationName!,
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return getSpaceHeight(AppConstants.pagePadding);
                              },
                              itemCount: destinationCtx
                                  .read<DestinationCubit>()
                                  .locationList
                                  .length),
                        ),
                      ],
                    ),
                  ),
                ),
                getSpaceHeight(30),
                CommonGlobalButton(
                  height: 48,
                  buttonBackgroundColor: AppConstants.mainColor,
                  isEnable: destinationCtx
                              .read<DestinationCubit>()
                              .destinationFrom !=
                          null &&
                      destinationCtx.read<DestinationCubit>().destinationTo !=
                          null,
                  // isLoading:
                  // loginState is UserLoginLoadingState,
                  buttonTextSize: AppConstants.normalFontSize,
                  buttonTextFontWeight: FontWeight.w700,
                  buttonText: AppLocalizations.of(context)!.lblConfirm,
                  onPressedFunction: () {
                    if (formKey.currentState!.validate()) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  },
                ),
                getSpaceHeight(50),
              ],
            ],
          );
        },
      ),
    );
  }
}
