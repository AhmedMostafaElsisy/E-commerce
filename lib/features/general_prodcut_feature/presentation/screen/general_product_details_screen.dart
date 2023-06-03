import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../store_product/presentation/widget/product_image_slider.dart';
import '../../../store_product/presentation/widget/product_states_widget.dart';
import '../logic/product_details_cubit/product_details_cubit.dart';
import '../logic/product_details_cubit/product_details_states.dart';
import '../widget/product_add_cart_with_quantity.dart';
import '../widget/product_favorite_button.dart';
import '../widget/product_location_and_time.dart';
import '../widget/product_price_and_discount.dart';
import '../widget/product_store_with_contact_widget.dart';

class GeneralProductDetailsScreen extends StatefulWidget {
  final RouteArgument argument;

  const GeneralProductDetailsScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  State<GeneralProductDetailsScreen> createState() =>
      _GeneralProductDetailsScreenState();
}

class _GeneralProductDetailsScreenState
    extends State<GeneralProductDetailsScreen> {
  late ProductDetailsCubit productCubit;

  @override
  void initState() {
    super.initState();
    productCubit = BlocProvider.of<ProductDetailsCubit>(context);
    productCubit.getProductDetails(
        productId: widget.argument.productModel!.id!.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MainAppPage(
      screenContent: Scaffold(
        backgroundColor: AppConstants.transparent,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: BlocConsumer<ProductDetailsCubit, ProductDetailsStates>(
            listener: (productCtx, productState) {
              if (productState is ProductDetailsFailedStates) {
                checkUserAuth(
                    context: productCtx, errorType: productState.error.type);
              }
            },
            builder: (productCtx, productState) {
              return Stack(
                children: [
                  Column(
                    children: [
                      CommonAppBar(
                        withBack: true,
                        appBarBackGroundColor: AppConstants.transparent,
                        showBottomIcon: false,
                        centerTitle: false,
                        titleWidget: CommonTitleText(
                          textKey:
                              "${AppLocalizations.of(context)!.lblShow} ${widget.argument.productModel!.name!}",
                          textColor: AppConstants.lightBlackColor,
                          textWeight: FontWeight.w400,
                          textFontSize: AppConstants.normalFontSize,
                        ),
                      ),
                      if (productState is ProductDetailsLoadingStates) ...[
                        const CommonLoadingWidget()
                      ] else if (productState
                          is ProductDetailsFailedStates) ...[
                        CommonError(
                          errorMassage: productState.error.errorMassage,
                          withButton: true,
                          onTap: () => productCubit.getProductDetails(
                              productId:
                                  widget.argument.productModel!.id!.toString()),
                        )
                      ] else ...[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  getWidgetWidth(AppConstants.pagePadding)),
                          child: SizedBox(
                            height: getWidgetHeight(710),
                            width: getWidgetWidth(375),
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              children: [
                                ///product image slider
                                ProductImageSlider(
                                  model: productCubit.product,
                                ),

                                ///store information
                                ProductStoreInformationWithRating(
                                  model: productCubit.product,
                                ),

                                ///Spacer
                                getSpaceHeight(AppConstants.smallPadding),
                                ProductLocationAndTime(
                                    product: productCubit.product),
                                //space
                                getSpaceHeight(
                                  AppConstants.smallPadding,
                                ),

                                ///product information
                                ProductInformationWidget(
                                  model: productCubit.product,
                                ),

                                ///Spacer
                                getSpaceHeight(AppConstants.smallPadding),

                                //description
                                RichText(
                                  text: HTML.toTextSpan(
                                    context,
                                    productCubit.product.description!,
                                    defaultTextStyle: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                          color: AppConstants.mainTextColor,
                                          fontSize: AppConstants.smallFontSize,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.visible,
                                        ),
                                  ),
                                ),

                                getSpaceHeight(100),
                              ],
                            ),
                          ),
                        )
                      ],
                    ],
                  ),
                  if (productState is! ProductDetailsLoadingStates &&
                      productState is! ProductDetailsFailedStates)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: SharedText.screenWidth,
                          height: getWidgetHeight(80),
                          decoration: BoxDecoration(
                              color: AppConstants.lightWhiteColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppConstants
                                    .containerOfListTitleBorderRadius),
                                topRight: Radius.circular(AppConstants
                                    .containerOfListTitleBorderRadius),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: AppConstants.lightBlackColor
                                        .withOpacity(0.16),
                                    offset: const Offset(0, 0),
                                    blurRadius: 4)
                              ]),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  getWidgetWidth(AppConstants.pagePadding),
                              vertical:
                                  getWidgetHeight(AppConstants.pagePadding)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              getSpaceWidth(16),
                              Expanded(
                                child: ProductPriceAndDiscountWidget(
                                  product: productCubit.product,
                                ),
                              ),
                              getSpaceWidth(16),
                              AddProductToCartWithQuantity(
                                product: productCubit.product,
                              ),
                              getSpaceWidth(4),
                              ProductFavoriteButton(
                                product: productCubit.product,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
