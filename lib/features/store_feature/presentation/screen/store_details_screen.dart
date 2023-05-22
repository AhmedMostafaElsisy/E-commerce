import 'dart:io';

import 'package:captien_omda_customer/core/presentation/Routes/route_names.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_empty_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_loading_widget.dart';
import 'package:captien_omda_customer/features/store_feature/presentation/screen/store_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_argument_model.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/product_item_widget.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../Chat_Feature/Data/chat_models/chat_user_model.dart';
import '../logic/single_store_cubit/my_store_cubit.dart';
import '../logic/single_store_cubit/my_store_states.dart';

class StoreDetailsScreen extends StatefulWidget {
  final RouteArgument argument;

  const StoreDetailsScreen({Key? key, required this.argument})
      : super(key: key);

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  late MyStoreCubit myStoreCubit;

  @override
  void initState() {
    super.initState();
    myStoreCubit = BlocProvider.of<MyStoreCubit>(context);
    myStoreCubit.getStoreProductList(shopID: widget.argument.shopModel!.id!);
    myStoreCubit.scrollController = ScrollController();
    myStoreCubit.scrollController.addListener(
      () {
        myStoreCubit.setupScrollController(
            shopID: widget.argument.shopModel!.id!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      body: MainAppPage(
        screenContent: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            CommonAppBar(
              withBack: true,
              appBarBackGroundColor: AppConstants.transparent,
              showBottomIcon: false,
              centerTitle: false,
              titleWidget: CommonTitleText(
                textKey:
                    "${AppLocalizations.of(context)!.lblStore}  ${widget.argument.shopModel!.name}",
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
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getWidgetWidth(AppConstants.pagePadding)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ///store info card
                    StoreInfoCard(
                      shopModel: widget.argument.shopModel!,
                      showStoreFunc: false,
                    ),
                    getSpaceHeight(AppConstants.smallPadding),
                    Container(
                      height: getWidgetHeight(40),
                      width: SharedText.screenWidth,
                      padding: EdgeInsets.all(getWidgetHeight(10)),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppConstants.smallRadius),
                          color: AppConstants.lightOrangColor),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonTitleText(
                              textKey: widget.argument.shopModel!.email!,
                              textFontSize: AppConstants.smallFontSize,
                              textWeight: FontWeight.w600,
                              textColor: AppConstants.lightOrangeColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    if (Platform.isIOS) {
                                      await launchUrl(
                                        Uri(
                                          scheme: "tel",
                                          path:
                                              widget.argument.shopModel!.phone,
                                        ),
                                      );
                                    } else {
                                      await launchUrl(Uri(
                                        scheme: 'tel',
                                        path: widget.argument.shopModel!.phone,
                                      ));
                                    }
                                  },
                                  child: const CommonAssetSvgImageWidget(
                                    imageString: "call.svg",
                                    height: 16,
                                    width: 16,
                                    fit: BoxFit.contain,
                                    imageColor: AppConstants.lightOrangeColor,
                                  ),
                                ),
                                getSpaceWidth(16),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      RouteNames.chatPageRoute,
                                      arguments: RouteArgument(
                                        chatUserModel:
                                            ChatUserModel.fromUserBaseModel(
                                                widget
                                                    .argument.shopModel!.user!),
                                      ),
                                    );
                                  },
                                  child: const CommonAssetSvgImageWidget(
                                    imageString: "chat.svg",
                                    height: 16,
                                    width: 16,
                                    fit: BoxFit.contain,
                                    imageColor: AppConstants.lightOrangeColor,
                                  ),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    getSpaceHeight(AppConstants.smallPadding),
                    BlocConsumer<MyStoreCubit, MyStoreStates>(
                      listener: (myStoreCtx, myStoreState) {
                        if (myStoreState is MyStoreFailedStates) {
                          checkUserAuth(
                              context: myStoreCtx,
                              errorType: myStoreState.error.type);
                        }
                      },
                      builder: (myStoreCtx, myStoreState) {
                        if (myStoreState is MyStoreLoadingStates) {
                          return const CommonLoadingWidget();
                        } else if (myStoreState is MyStoreFailedStates) {
                          return CommonError(
                            errorMassage: myStoreState.error.errorMassage,
                            withButton: true,
                            onTap: () => myStoreCubit
                              ..getStoreProductList(
                                  shopID: widget.argument.shopModel!.id!),
                          );
                        } else if (myStoreCtx
                            .read<MyStoreCubit>()
                            .productList
                            .isEmpty) {
                          return EmptyScreen(
                              imageString: "category.svg",
                              titleKey: AppLocalizations.of(context)!
                                  .lblNoProductFound,
                              imageHeight: 80,
                              withButton: true,
                              buttonText: AppLocalizations.of(context)!
                                  .lblNoProductFoundDesc,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    RouteNames.addNewProductPageRoute,
                                    arguments: RouteArgument(
                                        shopModel: widget.argument.shopModel!));
                              },
                              imageWidth: 08);
                        } else {
                          return SizedBox(
                            height: SharedText.screenHeight - 225,
                            child: Column(
                              children: [
                                Expanded(
                                  child: GridView.builder(
                                    controller: myStoreCubit.scrollController,
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: getWidgetWidth(8),
                                      mainAxisSpacing: getWidgetHeight(16),
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.20),
                                    ),
                                    itemCount: myStoreCtx
                                            .read<MyStoreCubit>()
                                            .productList
                                            .length +
                                        1,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (index >=
                                              myStoreCtx
                                                  .read<MyStoreCubit>()
                                                  .productList
                                                  .length &&
                                          myStoreCtx
                                              .read<MyStoreCubit>()
                                              .hasMoreData) {
                                        return const CommonLoadingWidget();
                                      } else if (index >=
                                          myStoreCtx
                                              .read<MyStoreCubit>()
                                              .productList
                                              .length) {
                                        return const SizedBox();
                                      } else {
                                        return ProductItemWidget(
                                          showFavIcon: false,
                                          model: myStoreCtx
                                              .read<MyStoreCubit>()
                                              .productList[index],
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
