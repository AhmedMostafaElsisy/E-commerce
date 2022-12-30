import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_loading_widget.dart';
import 'package:captien_omda_customer/features/favorite_feature/presentation/logic/favorite_cubit.dart';
import 'package:captien_omda_customer/features/favorite_feature/presentation/logic/favorite_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/presentation/Widgets/shop_item_widget.dart';

class MyStoresListScreen extends StatefulWidget {
  const MyStoresListScreen({Key? key}) : super(key: key);

  @override
  State<MyStoresListScreen> createState() => _MyStoresListScreenState();
}

class _MyStoresListScreenState extends State<MyStoresListScreen> {
  late FavoriteCubit favoriteCubit;

  @override
  void initState() {
    super.initState();
    favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    favoriteCubit.getFavoriteListData();
    favoriteCubit.scrollController = ScrollController();
    favoriteCubit.scrollController.addListener(
      () {
        favoriteCubit.setupScrollController();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: AppConstants.lightWhiteColor,
      appBar: CommonAppBar(
          withBack: true,
          appBarBackGroundColor: AppConstants.transparent,
          showBottomIcon: false,
          centerTitle: false,
          titleWidget: CommonTitleText(
            textKey: AppLocalizations.of(context)!.lblMyShop,
            textColor: AppConstants.lightBlackColor,
            textWeight: FontWeight.w400,
            textFontSize: AppConstants.normalFontSize,
          ),
          customActionWidget: InkWell(
            onTap: () {
              ///Todo: add navigator to create shop
            },
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: CommonAssetSvgImageWidget(
                      imageString: "add.svg", height: 16, width: 16),
                ),
                CommonTitleText(
                  textKey: AppLocalizations.of(context)!.lblAddStore,
                  textColor: AppConstants.lightOrangeColor,
                  textWeight: FontWeight.w600,
                  textFontSize: AppConstants.smallFontSize,
                ),
              ],
            ),
          )),
      body: Container(
        width: SharedText.screenWidth,
        height: SharedText.screenHeight,
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
                "assets/images/backGround.png",
              ),
              fit: BoxFit.fill),
          gradient: LinearGradient(
            colors: [
              AppConstants.lightWhiteColor.withOpacity(0.28),
              AppConstants.lightWhiteColor
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getWidgetWidth(AppConstants.pagePadding)),
          child: Column(
            children: [
              getSpaceHeight(80),
              BlocConsumer<FavoriteCubit, FavoriteStates>(
                listener: (favCtx, favState) {
                  if (favState is FavoriteFailedStates) {
                    checkUserAuth(
                        context: favCtx, errorType: favState.error.type);
                  }
                },
                builder: (favCtx, favState) {
                  if (favState is FavoriteLoadingStates) {
                    return const CommonLoadingWidget();
                  } else if (favState is FavoriteFailedStates) {
                    return CommonError(
                      errorMassage: favState.error.errorMassage,
                      withButton: true,
                      onTap: () => favoriteCubit.getFavoriteListData(),
                    );
                  } else {
                    return SizedBox(
                      height: SharedText.screenHeight - 110,
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              controller: favoriteCubit.scrollController,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: getWidgetWidth(8),
                                mainAxisSpacing: getWidgetHeight(8),
                                childAspectRatio: MediaQuery.of(context)
                                        .size
                                        .width /
                                    (MediaQuery.of(context).size.height / 1.28),
                              ),
                              itemCount: favCtx
                                      .read<FavoriteCubit>()
                                      .productList
                                      .length +
                                  1,
                              itemBuilder: (BuildContext context, int index) {
                                if (index >=
                                        favCtx
                                            .read<FavoriteCubit>()
                                            .productList
                                            .length &&
                                    favCtx.read<FavoriteCubit>().hasMoreData) {
                                  return const CommonLoadingWidget();
                                } else if (index >=
                                    favCtx
                                        .read<FavoriteCubit>()
                                        .productList
                                        .length) {
                                  return const SizedBox();
                                } else {
                                  return ShopItemWidget(
                                    model: favCtx
                                        .read<FavoriteCubit>()
                                        .productList[index].shopModel!,
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
            ],
          ),
        ),
      ),
    );
  }
}
