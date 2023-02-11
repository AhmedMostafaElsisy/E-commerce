import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/Helpers/shared_texts.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_app_bar_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_empty_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_loading_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/shop_grid_item_widget.dart';
import 'package:captien_omda_customer/core/presentation/screen/main_app_page.dart';
import 'package:captien_omda_customer/features/store_feature/presentation/logic/general_stores_cubit/general_stores_cubit.dart';
import 'package:captien_omda_customer/features/store_feature/presentation/logic/general_stores_cubit/general_stores_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';

class GeneralStoresListScreen extends StatefulWidget {
  const GeneralStoresListScreen({Key? key}) : super(key: key);

  @override
  State<GeneralStoresListScreen> createState() =>
      _GeneralStoresListScreenState();
}

class _GeneralStoresListScreenState extends State<GeneralStoresListScreen> {
  late GeneralStoresCubit generalStoresCubit;

  @override
  void initState() {
    super.initState();
    generalStoresCubit = BlocProvider.of<GeneralStoresCubit>(context);
    generalStoresCubit.getGeneralStoresListData();
    generalStoresCubit.scrollController = ScrollController();
    generalStoresCubit.scrollController.addListener(
      () {
        generalStoresCubit.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainAppPage(
      screenContent: Scaffold(
        backgroundColor: AppConstants.transparent,
        appBar: CommonAppBar(
          withBack: false,
          appBarBackGroundColor: AppConstants.transparent,
          showBottomIcon: false,
          leadingWidth: getWidgetWidth(16),
          centerTitle: false,
          titleWidget: CommonTitleText(
            textKey: AppLocalizations.of(context)!.lblStores,
            textColor: AppConstants.lightBlackColor,
            textWeight: FontWeight.w400,
            textFontSize: AppConstants.normalFontSize,
          ),
          customActionWidget: InkWell(
            onTap: () {
              //todo:add navigation to filter feature here
            },
            child: const CommonAssetSvgImageWidget(
              imageString: "filter.svg",
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),
        body: BlocConsumer<GeneralStoresCubit, GeneralStoresStates>(
          listener: (storeCtx, storeState) {
            if (storeState is GeneralStoresFailedStates) {
              checkUserAuth(
                  context: storeCtx, errorType: storeState.error.type);
            }
          },
          builder: (storeCtx, storeState) {
            if (storeState is GeneralStoresLoadingStates) {
              return const CommonLoadingWidget();
            } else if (storeState is GeneralStoresFailedStates) {
              return CommonError(
                errorMassage: storeState.error.errorMassage,
                withButton: true,
                onTap: () => generalStoresCubit.getGeneralStoresListData(),
              );
            } else if (storeCtx
                .read<GeneralStoresCubit>()
                .generalGeneralStoressList
                .isEmpty) {
              return EmptyScreen(
                  imageString: "category.svg",
                  titleKey: AppLocalizations.of(context)!.lblNoStoreFound,
                  description:
                      AppLocalizations.of(context)!.lblNoStoreFoundDesc,
                  imageHeight: 80,
                  imageWidth: 08);
            } else {
              return SizedBox(
                height: SharedText.screenHeight - 110,
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        controller: generalStoresCubit.scrollController,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: getWidgetWidth(8),
                          mainAxisSpacing: getWidgetHeight(8),
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 1.78),
                        ),
                        itemCount: storeCtx
                                .read<GeneralStoresCubit>()
                                .generalGeneralStoressList
                                .length +
                            1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index >=
                                  storeCtx
                                      .read<GeneralStoresCubit>()
                                      .generalGeneralStoressList
                                      .length &&
                              storeCtx.read<GeneralStoresCubit>().hasMoreData) {
                            return const CommonLoadingWidget();
                          } else if (index >=
                              storeCtx
                                  .read<GeneralStoresCubit>()
                                  .generalGeneralStoressList
                                  .length) {
                            return const SizedBox();
                          } else {
                            return ShopGridItemWidget(
                              model: storeCtx
                                  .read<GeneralStoresCubit>()
                                  .generalGeneralStoressList[index],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
