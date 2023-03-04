import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/features/cart_feature/presenation/logic/cart_cubit.dart';
import 'package:captien_omda_customer/features/cart_feature/presenation/logic/cart_events.dart';
import 'package:captien_omda_customer/features/cart_feature/presenation/logic/cart_states.dart';
import 'package:captien_omda_customer/features/cart_feature/presenation/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../../core/presentation/screen/main_app_page.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../../core/presentation/Widgets/custom_alert_dialog.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  late TextEditingController searchController;
  late CartBloc cartCubit;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    cartCubit = BlocProvider.of<CartBloc>(context);
    cartCubit.add(GetCartItemEvent());
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
          screenContent: BlocConsumer<CartBloc, CartState>(
            listener: (cartCtx, cartState) {
              if (cartState is CheckoutFailedState) {
                checkUserAuth(
                    context: context, errorType: cartState.error.type);
                showSnackBar(
                  context: context,
                  title: cartState.error.errorMassage ?? "",
                );
              } else if (cartState is CheckoutSuccessState) {
                showAlertDialog(context, [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getSpaceHeight(AppConstants.pagePadding),
                      const CommonAssetSvgImageWidget(
                          imageString: "sucess.svg", height: 40, width: 40),
                      getSpaceHeight(AppConstants.pagePadding),
                      CommonTitleText(
                        textKey:
                            AppLocalizations.of(context)!.lblCheckoutSuccess,
                        textColor: AppConstants.mainTextColor,
                        lines: 3,
                        textFontSize: AppConstants.smallFontSize,
                        textWeight: FontWeight.w700,
                      ),
                      getSpaceHeight(AppConstants.pagePadding),
                      CommonGlobalButton(
                          showBorder: true,
                          borderColor: AppConstants.mainColor,
                          width: 160,
                          buttonTextFontWeight: FontWeight.w600,
                          buttonTextSize: AppConstants.normalFontSize,
                          elevation: 0,
                          buttonBackgroundColor: AppConstants.mainColor,
                          buttonTextColor: AppConstants.lightWhiteColor,
                          buttonText:
                              AppLocalizations.of(context)!.lblBackToHome,
                          onPressedFunction: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                RouteNames.mainBottomNavPageRoute,
                                (route) => false);
                          },
                          height: 48,
                          radius: AppConstants.containerBorderRadius,
                          withIcon: false),
                      getSpaceWidth(16),
                      getSpaceHeight(AppConstants.pagePadding),
                    ],
                  )
                ]);
              }
            },
            builder: (cartCtx, cartState) {
              if (cartState is GetCartItemsLoadingState ||
                  cartState is AddProductToCartLoadingState ||
                  cartState is RemoveProductToCartLoadingState ||
                  cartState is CheckoutLoadingState ||
                  cartState is ChangeProductQuantityLoadingState) {
                return const CommonLoadingWidget();
              } else if (cartState is GetCartItemsFailedState) {
                return CommonError(
                  errorMassage: cartState.error.errorMassage,
                  withButton: true,
                  onTap: () => cartCubit.add(GetCartItemEvent()),
                );
              } else if (cartCubit.cartItems.isEmpty) {
                return Column(
                  children: [
                    CommonAppBar(
                      withBack: true,
                      appBarBackGroundColor: AppConstants.transparent,
                      showBottomIcon: false,
                      centerTitle: false,
                      titleWidget: CommonTitleText(
                        textKey: AppLocalizations.of(context)!.lblMyCart,
                        textColor: AppConstants.lightBlackColor,
                        textWeight: FontWeight.w400,
                        textFontSize: AppConstants.normalFontSize,
                      ),
                    ),
                    getSpaceHeight(96),
                    EmptyScreen(
                        imageString: "category.svg",
                        titleKey: AppLocalizations.of(context)!.lblCartEmpty,
                        description: AppLocalizations.of(context)!
                            .lblYouNeedToAddProduct,
                        imageHeight: 80,
                        imageWidth: 08),
                  ],
                );
              } else {
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
                            textKey: AppLocalizations.of(context)!.lblMyCart,
                            textColor: AppConstants.lightBlackColor,
                            textWeight: FontWeight.w400,
                            textFontSize: AppConstants.normalFontSize,
                          ),
                        ),

                        ///spacer
                        Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      getWidgetWidth(AppConstants.pagePadding),
                                  vertical: getWidgetHeight(
                                      AppConstants.smallPadding)),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CartItemWidget(
                                  cartItem:
                                      cartCtx.read<CartBloc>().cartItems[index],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return getSpaceHeight(AppConstants.pagePadding);
                              },
                              itemCount: cartCubit.cartItems.length),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: getWidgetHeight(16),
                            right: getWidgetWidth(16),
                            left: getWidgetWidth(16),
                            bottom: getWidgetWidth(24),
                          ),
                          decoration: BoxDecoration(
                            color: AppConstants.lightWhiteColor,
                            boxShadow: [
                              BoxShadow(
                                color: AppConstants.lightBlackColor
                                    .withOpacity(.16),
                                blurRadius: 4,
                              ),
                            ],
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              topLeft: Radius.circular(8),
                            ),
                          ),
                          width: getWidgetWidth(375),
                          height: getWidgetHeight(150),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                height: getWidgetHeight(40),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppConstants.lightOrangColor,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CommonTitleText(
                                      textKey: AppLocalizations.of(context)!
                                          .lblTotalPrice,
                                      textWeight: FontWeight.bold,
                                      textFontSize: AppConstants.xSmallFontSize,
                                    ),
                                    Row(
                                      children: [
                                        CommonTitleText(
                                          textKey:
                                              "${cartCubit.totalPriceOfCartItems()} ",
                                          textColor:
                                              AppConstants.lightOrangeColor,
                                          textWeight: FontWeight.bold,
                                          textFontSize:
                                              AppConstants.normalFontSize,
                                        ),
                                        CommonTitleText(
                                          textKey: AppLocalizations.of(context)!
                                              .lblEGP,
                                          textColor:
                                              AppConstants.lightOrangeColor,
                                          textWeight: FontWeight.bold,
                                          textFontSize:
                                              AppConstants.normalFontSize,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              getSpaceHeight(16),
                              CommonGlobalButton(
                                iconWidth: 16,
                                iconHeight: 16,
                                isLoading:
                                    cartState is GetCartItemsLoadingState ||
                                        cartState
                                            is AddProductToCartLoadingState ||
                                        cartState
                                            is RemoveProductToCartLoadingState ||
                                        cartState is CheckoutLoadingState ||
                                        cartState
                                            is ChangeProductQuantityLoadingState,
                                isEnable: !(cartState
                                        is GetCartItemsLoadingState ||
                                    cartState is AddProductToCartLoadingState ||
                                    cartState
                                        is RemoveProductToCartLoadingState ||
                                    cartState is CheckoutLoadingState ||
                                    cartState
                                        is ChangeProductQuantityLoadingState),
                                iconColor: AppConstants.lightWhiteColor,
                                buttonText:
                                    AppLocalizations.of(context)!.lblCheckout,
                                onPressedFunction: () {
                                  cartCtx
                                      .read<CartBloc>()
                                      .add(ConfirmOrderEvent());
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
