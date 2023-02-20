import 'package:captien_omda_customer/features/general_prodcut_feature/presentation/logic/product_list_cubit/product_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/product_item_widget.dart';
import '../logic/product_list_cubit/product_list_states.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ProductListCubitWithFilter productListCubitWithFilter;

  @override
  void initState() {
    super.initState();
    productListCubitWithFilter =
        BlocProvider.of<ProductListCubitWithFilter>(context);
    productListCubitWithFilter.scrollController = ScrollController();
    productListCubitWithFilter.scrollController.addListener(
      () {
        productListCubitWithFilter.setupScrollController();
      },
    );
    productListCubitWithFilter.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        withBack: true,
        appBarBackGroundColor: AppConstants.transparent,
        showBottomIcon: false,
        centerTitle: false,
        titleWidget: CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblFeaturedProducts,
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
      body: BlocConsumer<ProductListCubitWithFilter, ProductListStates>(
        listener: (productListCtx, productListState) {
          if (productListState is ProductListFailedStates) {
            checkUserAuth(
                context: productListCtx,
                errorType: productListState.error.type);
          }
        },
        builder: (productListCtx, productListState) {
          if (productListState is ProductListLoadingStates) {
            return const CommonLoadingWidget();
          } else if (productListState is ProductListFailedStates) {
            return CommonError(
              errorMassage: productListState.error.errorMassage,
              withButton: true,
              onTap: () => productListCubitWithFilter.getProducts(),
            );
          } else if (productListCubitWithFilter.products.isEmpty) {
            return EmptyScreen(
                imageString: "category.svg",
                titleKey: AppLocalizations.of(context)!.lblNoResultFount,
                imageHeight: 80,
                withButton: false,
                imageWidth: 08);
          } else {
            return SizedBox(
              height: getWidgetHeight(700),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      controller: productListCubitWithFilter.scrollController,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: getWidgetWidth(8),
                        mainAxisSpacing: getWidgetHeight(16),
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.28),
                      ),
                      itemCount: productListCubitWithFilter.products.length + 2,
                      itemBuilder: (BuildContext context, int index) {
                        if (index >=
                                productListCubitWithFilter.products.length &&
                            productListCubitWithFilter.hasMoreData) {
                          return const CommonLoadingWidget();
                        } else if (index >=
                            productListCubitWithFilter.products.length) {
                          return const SizedBox();
                        } else {
                          return ProductItemWidget(
                            showFavIcon: true,
                            model: productListCubitWithFilter.products[index],
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
    );
  }
}
