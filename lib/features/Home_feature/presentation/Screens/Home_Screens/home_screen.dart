import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/Helpers/shared_texts.dart';
import 'package:captien_omda_customer/core/presentation/Routes/route_names.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/category_grid_item_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_app_bar_icon_with_counter.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/screens/app_main_screen.dart';
import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_cubit.dart';
import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_states.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/Widgets/banner_carousel_widget.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/Widgets/stores_list_widget.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/Bottom_Nav_Cubit/bottom_nav_cubit.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/home_cubit/home_cubit.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/home_cubit/home_states.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/home_product_cubit/home_product_cubit.dart';
import 'package:captien_omda_customer/features/Home_feature/presentation/logic/home_product_cubit/home_product_states.dart';
import 'package:captien_omda_customer/features/store_feature/presentation/logic/general_stores_cubit/general_stores_cubit.dart';
import 'package:captien_omda_customer/features/store_feature/presentation/logic/general_stores_cubit/general_stores_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../Widgets/products_grid_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late BannersCubit bannersCubit;
  late GeneralStoresCubit generalStoresCubit;
  late TextEditingController searchController;
  late CategoriesCubit categoriesCubit;
  late HomeProductCubit productCubit;

  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    bannersCubit = BlocProvider.of<BannersCubit>(context);
    categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    generalStoresCubit = BlocProvider.of<GeneralStoresCubit>(context);
    productCubit = BlocProvider.of<HomeProductCubit>(context);
    searchController = TextEditingController();
    locationController = TextEditingController();
    bannersCubit.getBanners();
    categoriesCubit.getAllCategories();
    generalStoresCubit.getGeneralStoresListData();
    productCubit.getHomeProducts();
  }

  @override
  Widget build(BuildContext context) {
    return AppMainScreen(
        screen: Scaffold(
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
            /// search
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
                onTap: () {
                  SharedText.filterModel.clear();
                  Navigator.pushNamed(
                      context, RouteNames.productWithFilterScreen);
                },
                suffixIcon: SizedBox(
                  width: getWidgetWidth(16),
                  height: getWidgetHeight(16),
                  child: const Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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

            SizedBox(
              width: getWidgetWidth(343),
              height: getWidgetHeight(36),
              child: CommonTextFormField(
                controller: locationController,
                onTap: () {
                  SharedText.filterModel.clear();
                  Navigator.pushNamed(
                      context, RouteNames.productWithFilterScreen);
                },
                radius: AppConstants.textFormBorderRadius,
                keyboardType: TextInputType.text,
                isReadOnly: true,
                minLines: 1,
                maxLines: 1,
                hintKey: AppLocalizations.of(context)!.lblDetectLocation,
                labelHintColor: AppConstants.lightBlackColor,
                labelHintFontSize: AppConstants.xxSmallFontSize,
                withSuffixIcon: true,
                suffixIcon: SizedBox(
                  width: getWidgetWidth(16),
                  height: getWidgetHeight(16),
                  child: const Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            BlocConsumer<BannersCubit, HomeState>(
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
                      onTap: () => bannersCubit.getBanners(),
                    );
                  } else {
                    return SizedBox(
                        height: getWidgetHeight(132),
                        child: BannerCarouselWidget(
                          banners: bannersCubit.banners,
                        ));
                  }
                }),
            getSpaceHeight(12),

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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTitleText(
                              textKey: AppLocalizations.of(context)!
                                  .lblCategoriesLabel,
                              textWeight: FontWeight.w600,
                            ),
                            InkWell(
                              onTap: () {
                                BlocProvider.of<BottomNavCubit>(categoryCtx)
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
                      getSpaceHeight(8),
                      Expanded(
                        child: Row(
                          children: [
                            getSpaceWidth(24),
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (itemCtx, itemPos) {
                                  return CategoryGridItemWidget(
                                    categoryModel:
                                        categoriesCubit.categories[itemPos],
                                  );
                                },
                                itemCount: categoriesCubit.categories.length,
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
            getSpaceHeight(12),

            ///stores
            BlocConsumer<GeneralStoresCubit, GeneralStoresStates>(
                listener: (storeCtx, storeState) {},
                builder: (storeCtx, storeState) {
                  if (storeState is GeneralStoresLoadingStates) {
                    return Column(
                      children: const [
                        Center(
                          child: CircularProgressIndicator(
                            color: AppConstants.mainColor,
                          ),
                        )
                      ],
                    );
                  } else if (storeState is GeneralStoresFailedStates) {
                    return CommonError(
                      errorMassage: storeState.error.errorMassage,
                      withButton: true,
                      onTap: () =>
                          generalStoresCubit.getGeneralStoresListData(),
                    );
                  } else {
                    return Column(
                      children: [
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
                                      .selectItem(1);
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
                        getSpaceHeight(12),
                        StoresListWidget(
                          stores: generalStoresCubit.generalGeneralStoressList,
                        ),
                      ],
                    );
                  }
                }),
            getSpaceHeight(12),

            ///products
            BlocConsumer<HomeProductCubit, HomeProductStates>(
                listener: (productCtx, productState) {
                  if (productState is HomeProductFailedStates){
                    checkUserAuth(context: context, errorType: productState.error.type);
                  }
                },
                builder: (productCtx, productState) {
                  if (productState is HomeProductLoadingStates) {
                    return Column(
                      children: const [
                        Center(
                          child: CircularProgressIndicator(
                            color: AppConstants.mainColor,
                          ),
                        )
                      ],
                    );
                  } else if (productState is HomeProductFailedStates) {
                    return CommonError(
                      errorMassage: productState.error.errorMassage,
                      withButton: true,
                      onTap: () =>
                          generalStoresCubit.getGeneralStoresListData(),
                    );
                  } else {
                    return Column(
                      children: [
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
                                  SharedText.filterModel.clear();
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.productWithFilterScreen,
                                  );
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
                        getSpaceHeight(8),
                        ProductsGridWidget(
                          products: productCubit.products,
                        )
                      ],
                    );
                  }
                }),

            getSpaceHeight(80),
          ],
        ),
      ),
    ));
  }
}
