import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_loading_widget.dart';
import 'package:captien_omda_customer/features/favorite_feature/presentation/logic/favorite_cubit.dart';
import 'package:captien_omda_customer/features/favorite_feature/presentation/logic/favorite_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/product_item_widget.dart';
import '../../../../core/presentation/screen/main_app_page.dart';

class FavoriteListScreen extends StatefulWidget {
  const FavoriteListScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
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
      backgroundColor: AppConstants.lightWhiteColor,
      body: MainAppPage(
        screenContent: Column(children: [
          CommonAppBar(
            withBack: true,
            appBarBackGroundColor: AppConstants.transparent,
            showBottomIcon: false,
            centerTitle: false,
            titleWidget: CommonTitleText(
              textKey: AppLocalizations.of(context)!.lblFavorite,
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
                BlocConsumer<FavoriteCubit, FavoriteStates>(
                  listener: (favCtx, favState) {
                    if (favState is FavoriteFailedStates) {
                      checkUserAuth(
                          context: favCtx, errorType: favState.error.type);
                    } else if (favState is FavoriteRemoveFavSuccessStates) {
                      favCtx.read<FavoriteCubit>().removeItemFromFavLocal(
                          productId: favState.productId);
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
                    } else if (favCtx
                        .read<FavoriteCubit>()
                        .productList
                        .isEmpty) {
                      return EmptyScreen(
                          imageString: "category.svg",
                          titleKey:
                              AppLocalizations.of(context)!.lblNoStoreFound,
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
                                controller: favoriteCubit.scrollController,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: getWidgetWidth(8),
                                  mainAxisSpacing: getWidgetHeight(16),
                                  childAspectRatio:
                                      MediaQuery.of(context).size.width /
                                          (MediaQuery.of(context).size.height /
                                              1.2),
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
                                      favCtx
                                          .read<FavoriteCubit>()
                                          .hasMoreData) {
                                    return const CommonLoadingWidget();
                                  } else if (index >=
                                      favCtx
                                          .read<FavoriteCubit>()
                                          .productList
                                          .length) {
                                    return const SizedBox();
                                  } else {
                                    return ProductItemWidget(
                                      model: favCtx
                                          .read<FavoriteCubit>()
                                          .productList[index],
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
        ]),
      ),
    );
  }
}
