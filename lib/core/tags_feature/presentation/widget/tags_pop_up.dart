import 'package:captien_omda_customer/core/location_feature/presentation/widget/data_empty_widget.dart';
import 'package:captien_omda_customer/core/tags_feature/domain/model/tags_model.dart';
import 'package:captien_omda_customer/core/tags_feature/presentation/logic/tags_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared.dart';
import '../../../presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../presentation/Widgets/common_error_widget.dart';
import '../../../presentation/Widgets/common_global_button.dart';
import '../../../presentation/Widgets/common_text_form_field_widget.dart';
import '../../../presentation/Widgets/common_title_text.dart';
import '../../../presentation/Widgets/pop_up_item.dart';
import '../logic/tags_states.dart';

/// model list pop up with search
showTagsPopUp({
  required BuildContext context,
  required String title,
  required Function(List<TagsModel>) onApply,
  List<TagsModel>? preSelectedCity,
}) async {
  if (preSelectedCity != null) {
    TagsCubit.get(context).preSelectList(preSelectedCity);
  }
  return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          return BlocConsumer<TagsCubit, TagsLocationStates>(
            listener: (tagsCtx, tagsState) {},
            builder: (tagsCtx, tagsState) {
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
                                hintKey:
                                    AppLocalizations.of(context)!.lblSearchHere,
                                onChanged: (val) {
                                  tagsCtx
                                      .read<TagsCubit>()
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

                            if (tagsState is TagsLoadingState) ...[
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
                            ] else if (tagsState is TagsErrorState) ...[
                              CommonError(
                                onTap: () {
                                  tagsCtx
                                      .read<TagsCubit>()
                                      .getTagsData(limit: 100);
                                },
                                withButton: true,
                                errorMassage: tagsState.error?.errorMassage,
                              )
                            ] else ...[
                              if (tagsState is TagsEmptyState) ...[
                                NoDataFoundWidget(
                                  imageString: "no_area_found.svg",
                                  title: AppLocalizations.of(context)!
                                      .lblSubCategory,
                                  hint: AppLocalizations.of(context)!
                                      .lblSubCategory,
                                  showButton: false,
                                )
                              ] else ...[
                                ///list of items
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: tagsCtx
                                      .read<TagsCubit>()
                                      .tempTagsList
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
                                        tagsCtx
                                            .read<TagsCubit>()
                                            .setSelectedMultiTags(tagsCtx
                                                .read<TagsCubit>()
                                                .tempTagsList[index]);
                                      },
                                      child: PopUpItemWidget(
                                        isSelected: tagsCtx
                                            .read<TagsCubit>()
                                            .isThisTagSelected(tagsCtx
                                                .read<TagsCubit>()
                                                .tempTagsList[index]),
                                        name: tagsCtx
                                            .read<TagsCubit>()
                                            .tempTagsList[index]
                                            .name
                                            .toString(),
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
                        isEnable: tagsCtx
                            .read<TagsCubit>()
                            .selectedListTags
                            .isNotEmpty,
                        isLoading: tagsState is TagsLoadingState,
                        radius: AppConstants.smallBorderRadius,
                        buttonTextSize: 18,
                        buttonTextFontWeight: FontWeight.w400,
                        buttonText: AppLocalizations.of(context)!.lblConfirm,
                        onPressedFunction: () {
                          onApply(tagsCtx.read<TagsCubit>().selectedListTags);

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
