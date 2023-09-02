import 'package:captien_omda_customer/core/Constants/Enums/exception_enums.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/custom_snack_bar.dart';
import 'package:captien_omda_customer/features/cart_feature/presenation/logic/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_global_button.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../cart_feature/presenation/logic/cart_cubit.dart';
import '../../../cart_feature/presenation/logic/cart_events.dart';

class AddProductToCartWithQuantity extends StatefulWidget {
  final ProductModel product;
  final bool withAddToCart;

  const AddProductToCartWithQuantity({
    Key? key,
    required this.product,
    this.withAddToCart = true,
  }) : super(key: key);

  @override
  State<AddProductToCartWithQuantity> createState() =>
      _AddProductToCartWithQuantityState();
}

class _AddProductToCartWithQuantityState
    extends State<AddProductToCartWithQuantity> {
  late CartBloc cartBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = BlocProvider.of<CartBloc>(context);
    if (cartBloc.isProductOnCart(productModel: widget.product)) {
      widget.product.productTempQuantity = cartBloc
          .getProductQuantityIfFountOnCart(productModel: widget.product);
    }
    debugPrint(
        "here is acuall product Quantity ${widget.product.productTempQuantity.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      listener: (cartCtx, cartState) {
        if (cartState is ChangeProductQuantityFailedState) {
          checkUserAuth(context: context, errorType: cartState.error.type);
          if (cartState.error.type ==
                  CustomStatusCodeErrorType.quantityNotValid &&
              cartState.productThatInteractWith.id == widget.product.id) {
            showSnackBar(
              context: context,
              title: AppLocalizations.of(context)!.lblQuantityNotValid,
            );
          } else {
            ///todo: change "" to acceptable error
            showSnackBar(
                context: context, title: cartState.error.errorMassage ?? "");
          }
        } else if (cartState is AddProductToCartFailedState &&
            cartState.productThatInteractWith.id == widget.product.id) {
          checkUserAuth(context: context, errorType: cartState.error.type);

          ///todo: change "" to acceptable error
          showSnackBar(
            context: context,
            title: cartState.error.errorMassage ?? "",
          );
        } else if (cartState is AddProductToCartSuccessState &&
            cartState.productThatInteractWith.id == widget.product.id) {
          showSnackBar(
            context: context,
            color: AppConstants.successColor,
            title: AppLocalizations.of(context)!.lblProductAddedToCart,
          );
        } else if (cartState is RemoveProductToCartFailedState &&
            cartState.productThatInteractWith.id == widget.product.id) {
          checkUserAuth(context: context, errorType: cartState.error.type);

          ///todo: change "" to acceptable error
          showSnackBar(
            context: context,
            title: cartState.error.errorMassage ?? "",
          );
        } else if (cartState is RemoveProductToCartSuccessState &&
            cartState.productThatInteractWith.id == widget.product.id) {
          showSnackBar(
            context: context,
            color: AppConstants.successColor,
            title: AppLocalizations.of(context)!.lblProductRemovedToCart,
          );
        }
        widget.product.productTempQuantity = cartBloc
            .getProductQuantityIfFountOnCart(productModel: widget.product);
      },
      builder: (cartCtx, cartState) {
        return Row(
          children: [
            Container(
              height: getWidgetHeight(40),
              decoration: BoxDecoration(
                color: widget.withAddToCart
                    ? AppConstants.lightOrangColor
                    : AppConstants.loaderBackGroundColor,
                borderRadius: BorderRadius.circular(
                  AppConstants.smallRadius,
                ),
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      cartCtx
                          .read<CartBloc>()
                          .add(ChangeProductQuantityDependOnCartOrNotEvent(
                            productModel: widget.product,
                            quantity: 1,
                          ));
                    },
                    child: SizedBox(
                      width: getWidgetWidth(24),
                      child: const CommonTitleText(
                        textKey: "+",
                        textFontSize: AppConstants.mediumFontSize,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: getWidgetWidth(24),
                    child: CommonTitleText(
                      textKey: widget.product.productTempQuantity.toString(),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cartCtx
                          .read<CartBloc>()
                          .add(ChangeProductQuantityDependOnCartOrNotEvent(
                            productModel: widget.product,
                            quantity: -1,
                          ));
                    },
                    child: SizedBox(
                      width: getWidgetWidth(24),
                      child: const CommonTitleText(
                        textKey: "-",
                        textFontSize: AppConstants.mediumFontSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            getSpaceWidth(4),
            if (widget.withAddToCart) ...[
              if (cartBloc.isProductOnCart(productModel: widget.product)) ...[
                CommonGlobalButton(
                  width: 120,
                  withIcon: true,
                  iconPath: "remove_without_background.svg",
                  iconWidth: 16,
                  iconHeight: 16,
                  buttonBackgroundColor: AppConstants.lightOpacityRedColor,
                  elevation: 1,
                  isLoading: cartState is AddProductToCartLoadingState,
                  isEnable: cartState is! AddProductToCartLoadingState ||
                      cartState is! GetCartItemsLoadingState,
                  iconColor: AppConstants.lightRedColor,
                  buttonText: AppLocalizations.of(context)!.lblRemoveFromCart,
                  buttonTextColor: AppConstants.lightRedColor,
                  onPressedFunction: () {
                    cartCtx.read<CartBloc>().add(RemoveProductFromCartEvent(
                        productModel: widget.product));
                  },
                ),
              ] else ...[
                CommonGlobalButton(
                  width: 120,
                  withIcon: true,
                  iconPath: "shop_cart.svg",
                  iconWidth: 16,
                  iconHeight: 16,
                  isLoading: cartState is AddProductToCartLoadingState,
                  isEnable: cartState is! AddProductToCartLoadingState ||
                      cartState is! GetCartItemsLoadingState,
                  iconColor: AppConstants.lightWhiteColor,
                  buttonText: AppLocalizations.of(context)!.addToCart,
                  onPressedFunction: () {
                    cartCtx.read<CartBloc>().add(
                        AddProductToCartEvent(productModel: widget.product));
                  },
                ),
              ]
            ]
          ],
        );
      },
    );
  }
}
