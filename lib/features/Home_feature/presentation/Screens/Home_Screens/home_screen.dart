import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Routes/route_names.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/category_grid_item_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_app_bar_icon_with_counter.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/screens/app_main_screen.dart';
import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_cubit.dart';
import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_states.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/Widgets/banner_carousel_widget.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/Widgets/products_grid_widget.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/Widgets/stores_list_widget.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/home_cubit/home_cubit.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/home_cubit/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../../core/setting_feature/Logic/setting_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit homeContentCubit;
  late SettingCubit settingCubit;
  late TextEditingController searchController;
  late CategoriesCubit categoriesCubit;

  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    homeContentCubit = BlocProvider.of<HomeCubit>(context);
    settingCubit = BlocProvider.of<SettingCubit>(context);
    categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    searchController = TextEditingController();
    locationController = TextEditingController();
    settingCubit.getSetting();
    homeContentCubit.getHomeContent();
    categoriesCubit.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    //todo :change it to screen that cc used on app and remove yours
    return AppMainScreen(
      screen: BlocConsumer<HomeCubit, HomeState>(
        listener: (homeCtx, homeState) {},
        builder: (homeCtx, homeState) {
          if (homeState is HomeContentLoadingState) {
            return Column(
              children: const [
                Center(
                  child: CircularProgressIndicator(
                    color: AppConstants.mainColor,
                  ),
                )
              ],
            );
          } else if (homeState is HomeGetContentFailedState) {
            return CommonError(
              errorMassage: homeState.error.errorMassage,
              withButton: true,
              onTap: () => homeContentCubit.getHomeContent(),
            );
          } else {
            return Scaffold(
              backgroundColor: AppConstants.transparent,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: getWidgetHeight(35),
                    horizontal: getWidgetWidth(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonAssetImageWidget(
                        imageString: 'side_logo.png',
                        height: 36,
                        width: 100,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          CommonAppBarImageWithCounter(
                            imagePath: "fav_disable.svg",
                            withCounter: false,
                            navigationPath: RouteNames.favoritePageRoute,
                          ),
                          //todo: handel click on chat icon by navigation to chat screen
                          CommonAppBarImageWithCounter(
                            imagePath: "chat.svg",
                            withCounter: true,
                            itemCounter: 19,
                          ),
                          //todo: handel click on cart icon by navigation to cart screen
                          CommonAppBarImageWithCounter(
                            imagePath: "cart.svg",
                            withCounter: true,
                            itemCounter: 19,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// Email
                    SizedBox(
                      width: getWidgetWidth(343),
                      height: getWidgetHeight(36),
                      child: CommonTextFormField(
                        controller: searchController,
                        isReadOnly: true,
                        hintKey: AppLocalizations.of(context)!.lblSearchOn,
                        keyboardType: TextInputType.text,
                        labelHintColor: AppConstants.lightBlackColor,
                        labelHintFontSize: AppConstants.xxSmallFontSize,
                        radius: AppConstants.textFormBorderRadius,
                        withSuffixIcon: true,
                        suffixIcon: SizedBox(
                          width: getWidgetWidth(16),
                          height: getWidgetHeight(16),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: CommonAssetSvgImageWidget(
                                  imageString: "search.svg",
                                  height: 16,
                                  width: 16,
                                  imageColor: AppConstants.mainColor,
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                          return null;
                        },
                      ),
                    ),

                    ///spacer
                    getSpaceHeight(4),

                    /// Password
                    SizedBox(
                      width: getWidgetWidth(343),
                      height: getWidgetHeight(36),
                      child: CommonTextFormField(
                        controller: locationController,
                        radius: AppConstants.textFormBorderRadius,
                        keyboardType: TextInputType.text,
                        isReadOnly: true,
                        minLines: 1,
                        maxLines: 1,
                        hintKey:
                            AppLocalizations.of(context)!.lblDetectLocation,
                        labelHintColor: AppConstants.lightBlackColor,
                        labelHintFontSize: AppConstants.xxSmallFontSize,
                        withSuffixIcon: true,
                        suffixIcon: SizedBox(
                          width: getWidgetWidth(16),
                          height: getWidgetHeight(16),
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: CommonAssetSvgImageWidget(
                                  imageString: "location.svg",
                                  height: 16,
                                  width: 16,
                                  imageColor: AppConstants.mainColor,
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                          return null;
                        },
                      ),
                    ),
                    getSpaceHeight(12),

                    if (homeContentCubit.homeContent.banners.isNotEmpty)
                      SizedBox(
                          height: getWidgetHeight(132),
                          child: BannerCarouselWidget(
                            banners: homeContentCubit.homeContent.banners,
                          )),

                    BlocBuilder<CategoriesCubit, CategoryState>(
                        builder: (categoryCtx, categoryState) {
                      if (categoryState is CategoryLoadingState) {
                        return SizedBox(
                          width: getWidgetWidth(375),
                          height: getWidgetHeight(130),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Center(
                                child: CircularProgressIndicator(
                                  color: AppConstants.mainColor,
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (categoryState is GetCategoryFailedState) {
                        return CommonError(
                          errorMassage: categoryState.error.errorMassage,
                          withButton: true,
                          onTap: () => categoriesCubit.getAllCategories(),
                        );
                      } else {
                        return SizedBox(
                          width: getWidgetWidth(375),
                          height: getWidgetHeight(130),
                          child: Column(
                            children: [
                              getSpaceHeight(16),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidgetWidth(16)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonTitleText(
                                      textKey: AppLocalizations.of(context)!
                                          .lblCategoriesLabel,
                                      textWeight: FontWeight.w600,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<BottomNavCubit>(
                                                categoryCtx)
                                            .selectItem(2);
                                      },
                                      child: CommonTitleText(
                                        textKey: AppLocalizations.of(context)!
                                            .lblShowAll,
                                        textFontSize:
                                            AppConstants.xSmallFontSize,
                                        textColor:
                                            AppConstants.lightContentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              getSpaceHeight(8),
                              Expanded(
                                child: Row(
                                  children: [
                                    getSpaceWidth(24),
                                    Expanded(
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (itemCtx, itemPos) {
                                          return CategoryGridItemWidget(
                                            categoryModel: categoriesCubit
                                                .categories[itemPos],
                                          );
                                        },
                                        itemCount:
                                            categoriesCubit.categories.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return getSpaceWidth(30);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),

                    ///stores
                    if (homeContentCubit.homeContent.stores.isNotEmpty)
                      getSpaceHeight(12),
                    if (homeContentCubit.homeContent.stores.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidgetWidth(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!
                                  .lblFeaturedStores,
                              textWeight: FontWeight.w600,
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<BottomNavCubit>(context)
                                    .selectItem(2);
                              },
                              child: CommonTitleText(
                                textKey:
                                    AppLocalizations.of(context)!.lblShowAll,
                                textFontSize: AppConstants.xSmallFontSize,
                                textColor: AppConstants.lightContentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (homeContentCubit.homeContent.stores.isNotEmpty)
                      getSpaceHeight(8),
                    if (homeContentCubit.homeContent.stores.isNotEmpty)
                      StoresListWidget(
                        stores: homeContentCubit.homeContent.stores,
                      ),

                    ///products
                    if (homeContentCubit.homeContent.products.isNotEmpty)
                      getSpaceHeight(12),
                    if (homeContentCubit.homeContent.products.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getWidgetWidth(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!
                                  .lblFeaturedProducts,
                              textWeight: FontWeight.w600,
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<BottomNavCubit>(context)
                                    .selectItem(2);
                              },
                              child: CommonTitleText(
                                textKey:
                                    AppLocalizations.of(context)!.lblShowAll,
                                textFontSize: AppConstants.xSmallFontSize,
                                textColor: AppConstants.lightContentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (homeContentCubit.homeContent.products.isNotEmpty)
                      getSpaceHeight(8),
                    if (homeContentCubit.homeContent.products.isNotEmpty)
                      ProductsGridWidget(
                        products: homeContentCubit.homeContent.products,
                      ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
