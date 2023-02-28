import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/features/store_product/presentation/logic/product_cubit.dart';
import 'package:captien_omda_customer/features/store_product/presentation/logic/product_states.dart';
import 'package:captien_omda_customer/features/store_product/presentation/widget/product_image_slider.dart';
import 'package:captien_omda_customer/features/store_product/presentation/widget/product_states_widget.dart';
import 'package:captien_omda_customer/features/store_product/presentation/widget/product_store_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../store_product/presentation/widget/product_price_widget.dart';
import '../logic/product_details_cubit/product_details_cubit.dart';

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
          child: BlocConsumer<ProductCubit, ProductState>(
            listener: (productCtx, productState) {
              if (productState is GetProductDetailsErrorState) {
                checkUserAuth(
                    context: productCtx, errorType: productState.error.type);
              } else if (productState is DeleteProductErrorState) {
                checkUserAuth(
                    context: productCtx, errorType: productState.error.type);
                showSnackBar(
                  context: productCtx,
                  title: productState.error.errorMassage!,
                );
              } else if (productState is DeleteProductSuccessState) {
                Navigator.of(context).pop();
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
                      if (productState is GetProductDetailsLoadingState) ...[
                        const CommonLoadingWidget()
                      ] else if (productState
                          is GetProductDetailsErrorState) ...[
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///product image slider
                              ProductImageSlider(
                                model: widget.argument.productModel!,
                              ),

                              ///Spacer
                              getSpaceHeight(AppConstants.smallPadding),

                              ///product price
                              ProductPriceWidget(
                                productPrice:
                                    widget.argument.productModel!.price!,
                                oldPrice:
                                    widget.argument.productModel!.discount!,
                              ),

                              ///Spacer
                              getSpaceHeight(AppConstants.smallPadding),

                              ///product information
                              ProductInformationWidget(
                                model: widget.argument.productModel!,
                              ),

                              ///Spacer
                              getSpaceHeight(AppConstants.smallPadding),

                              ///store information
                              ProductStoreInformation(
                                model: widget.argument.productModel!,
                              ),

                              ///Spacer
                              getSpaceHeight(AppConstants.smallPadding),
                              CommonTitleText(
                                textKey:
                                    widget.argument.productModel!.description!,
                                textFontSize: AppConstants.smallFontSize,
                                textWeight: FontWeight.w400,
                                textColor: AppConstants.lightBlackColor,
                                lines: 15,
                                textAlignment: TextAlign.start,
                              ),
                            ],
                          ),
                        )
                      ],
                    ],
                  ),
                  if (productState is! GetProductDetailsLoadingState &&
                      productState is! GetProductDetailsErrorState)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: SharedText.screenWidth,
                          height: getWidgetHeight(70),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              /// todo: add cart buttons
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
