import 'package:captien_omda_customer/core/presentation/Routes/route_argument_model.dart';
import 'package:captien_omda_customer/core/presentation/Routes/route_names.dart';
import 'package:captien_omda_customer/features/order_feature/presentation/widget/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../../core/presentation/screen/main_app_page.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_text_form_field_widget.dart';
import '../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../core/presentation/Widgets/common_loading_widget.dart';
import 'logic/order_cubit.dart';
import 'logic/order_states.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  late TextEditingController searchController;
  late OrderCubit orderCubit;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    orderCubit = BlocProvider.of<OrderCubit>(context);
    orderCubit.getOrderListData();
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
          screenContent: BlocConsumer<OrderCubit, OrderStates>(
            listener: (orderCtx, orderState) {},
            builder: (orderCtx, orderState) {
              if (orderState is OrderLoadingStates) {
                return const CommonLoadingWidget();
              } else if (orderState is OrderFailedStates) {
                return CommonError(
                  errorMassage: orderState.error.errorMassage,
                  withButton: true,
                  onTap: () => orderCubit.getOrderListData(),
                );
              } else if (orderCtx.read<OrderCubit>().orderLst.isEmpty) {
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
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      RouteNames.orderDetailsPageRoute,
                                      arguments: RouteArgument(
                                        orderModel: orderCtx
                                            .read<OrderCubit>()
                                            .orderLst[index],
                                      ));
                                },
                                child: OrderItem(
                                  orderModel: orderCtx
                                      .read<OrderCubit>()
                                      .orderLst[index],
                                ));
                          },
                          separatorBuilder: (context, index) {
                            return getSpaceHeight(AppConstants.pagePadding);
                          },
                          itemCount:
                              orderCtx.read<OrderCubit>().orderLst.length),
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
