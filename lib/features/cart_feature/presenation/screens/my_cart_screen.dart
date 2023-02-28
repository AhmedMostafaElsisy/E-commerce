import 'package:captien_omda_customer/features/cart_feature/presenation/logic/cart_cubit.dart';
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
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  late TextEditingController searchController;
  late CartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    cartCubit = BlocProvider.of<CartCubit>(context);
    cartCubit.getCartItems();
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
          screenContent: BlocConsumer<CartCubit, CartState>(
            listener: (cartCtx, cartState) {},
            builder: (cartCtx, cartState) {
              if (cartState is GetCartItemsLoadingState) {
                return const CommonLoadingWidget();
              } else if (cartState is GetCartItemsFailedState) {
                return CommonError(
                  errorMassage: cartState.error.errorMassage,
                  withButton: true,
                  onTap: () => cartCubit.getCartItems(),
                );
              } else if (cartCubit.cartItems.isEmpty) {
                return EmptyScreen(
                    imageString: "category.svg",
                    titleKey: AppLocalizations.of(context)!.lblNoStoreFound,
                    description:
                        AppLocalizations.of(context)!.lblNoStoreFoundDesc,
                    imageHeight: 80,
                    imageWidth: 08);
              } else {
                return Column(
                  children: [
                    CommonAppBar(
                      withBack: true,
                      appBarBackGroundColor: AppConstants.transparent,
                      showBottomIcon: false,
                      centerTitle: false,
                      titleWidget: CommonTitleText(
                        textKey: AppLocalizations.of(context)!.lblOrders,
                        textColor: AppConstants.lightBlackColor,
                        textWeight: FontWeight.w400,
                        textFontSize: AppConstants.normalFontSize,
                      ),
                    ),

                    ///search
                    SizedBox(
                      width: getWidgetWidth(343),
                      height: getWidgetHeight(36),
                      child: CommonTextFormField(
                        controller: searchController,
                        isReadOnly: true,
                        hintKey: AppLocalizations.of(context)!.lblOrderSearch,
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
                    getSpaceHeight(AppConstants.pagePadding),
                    Expanded(
                      child: ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  getWidgetWidth(AppConstants.pagePadding),
                              vertical:
                                  getWidgetHeight(AppConstants.smallPadding)),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CartItemWidget(
                              cartItem:
                                  cartCtx.read<CartCubit>().cartItems[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return getSpaceHeight(AppConstants.pagePadding);
                          },
                          itemCount: cartCubit.cartItems.length),
                    )
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
