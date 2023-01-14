import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/features/store_product/presentation/logic/product_cubit.dart';
import 'package:captien_omda_customer/features/store_product/presentation/logic/product_states.dart';
import 'package:captien_omda_customer/features/store_product/presentation/widget/product_image_slider.dart';
import 'package:captien_omda_customer/features/store_product/presentation/widget/product_states_widget.dart';
import 'package:captien_omda_customer/features/store_product/presentation/widget/product_store_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/Constants/app_constants.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/Helpers/shared_texts.dart';
import '../../../core/presentation/Routes/route_names.dart';
import '../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../core/presentation/Widgets/common_global_button.dart';
import '../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../core/presentation/Widgets/common_title_text.dart';
import '../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../core/presentation/screen/main_app_page.dart';
import 'widget/product_price_widget.dart';

class ShowProductDetailsScreen extends StatefulWidget {
  final RouteArgument argument;

  const ShowProductDetailsScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  State<ShowProductDetailsScreen> createState() =>
      _ShowProductDetailsScreenState();
}

class _ShowProductDetailsScreenState extends State<ShowProductDetailsScreen> {
  late ProductCubit productCubit;

  @override
  void initState() {
    super.initState();
    productCubit = BlocProvider.of<ProductCubit>(context);
    productCubit.getProductDetails(
        productId: widget.argument.productModel!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainAppPage(
          screenContent: BlocConsumer<ProductCubit, ProductState>(
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
                              productId: widget.argument.productModel!.id!),
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
                                oldPrice: "1500",
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
                            children: [
                              /// edit
                              Expanded(
                                child: CommonGlobalButton(
                                    showBorder: false,
                                    buttonTextFontWeight: FontWeight.w600,
                                    buttonTextSize: AppConstants.normalFontSize,
                                    elevation: 0,
                                    isEnable: productState
                                        is! DeleteProductLoadingState,
                                    buttonBackgroundColor:
                                        AppConstants.mainColor,
                                    buttonText:
                                        AppLocalizations.of(context)!.lblEdit,
                                    onPressedFunction: () {
                                      Navigator.of(context).pushNamed(
                                          RouteNames.editProductPageRoute,
                                          arguments: RouteArgument(
                                              productModel: widget
                                                  .argument.productModel!));
                                    },
                                    height: 40,
                                    radius: AppConstants.containerBorderRadius,
                                    withIcon: false),
                              ),
                              getSpaceWidth(24),

                              /// delete
                              Expanded(
                                child: CommonGlobalButton(
                                  showBorder: true,
                                  borderColor: AppConstants.lightRedColor,
                                  buttonTextSize: AppConstants.normalFontSize,
                                  buttonTextFontWeight: FontWeight.w600,
                                  elevation: 0,
                                  isLoading:
                                      productState is DeleteProductLoadingState,
                                  buttonBackgroundColor:
                                      AppConstants.lightWhiteColor,
                                  buttonTextColor: AppConstants.lightRedColor,
                                  buttonText:
                                      AppLocalizations.of(context)!.lblDelete,
                                  onPressedFunction: () {
                                    productCubit.deleteProduct(
                                        productId:
                                            widget.argument.productModel!.id!);
                                  },
                                  height: 40,
                                ),
                              ),
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
