import 'package:captien_omda_customer/core/Constants/app_constants.dart';
import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/model/shop_model.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_cached_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';

class StoresListWidget extends StatefulWidget {
  final List<ShopModel> stores;

  const StoresListWidget({Key? key, required this.stores}) : super(key: key);

  @override
  State<StoresListWidget> createState() => _StoresListWidgetState();
}

class _StoresListWidgetState extends State<StoresListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: getWidgetHeight(164),
        child: Row(
          children: [
            getSpaceWidth(16),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (itemCtx, itemPos) {
                  return Container(
                    width: getWidgetWidth(90),
                    height: getWidgetHeight(164),
                    decoration: BoxDecoration(
                      color: AppConstants.lightWhiteColor,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: AppConstants.lightBlackColor.withOpacity(.16),
                          spreadRadius: 0,
                          blurRadius: 2,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        commonCachedImageWidget(
                          widget.stores[itemPos].image ?? "",
                          height: 80,
                          width: 90,
                          radius: 4,
                        ),
                        getSpaceHeight(8),
                        CommonTitleText(
                          textKey: widget.stores[itemPos].name ?? "",
                          textFontSize: AppConstants.xSmallFontSize,
                          textWeight: FontWeight.w600,
                        ),
                        getSpaceHeight(6),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidgetHeight(8),
                              vertical: getWidgetHeight(2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CommonAssetSvgImageWidget(
                                imageString: "stores.svg",
                                height: 16,
                                width: 16,
                                imageColor: AppConstants.mainColor,
                              ),
                              getSpaceWidth(4),
                              Expanded(
                                child: CommonTitleText(
                                  textKey:
                                      widget.stores[itemPos].category!.name,
                                  textFontSize: AppConstants.xxSmallFontSize,
                                  textWeight: FontWeight.w400,
                                  textColor: AppConstants.lightBorderColor,
                                  textAlignment: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidgetHeight(8),
                              vertical: getWidgetHeight(2)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CommonAssetSvgImageWidget(
                                imageString: "location.svg",
                                height: 16,
                                width: 16,
                                imageColor: AppConstants.mainColor,
                              ),
                              getSpaceWidth(4),
                              Expanded(
                                child: CommonTitleText(
                                  textKey:
                                      widget.stores[itemPos].address ?? "",
                                  textFontSize: AppConstants.xxSmallFontSize,
                                  textWeight: FontWeight.w400,
                                  textColor: AppConstants.lightBorderColor,
                                  textAlignment: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: widget.stores.length,
                separatorBuilder: (BuildContext context, int index) {
                  return getSpaceWidth(8);
                },
              ),
            ),
          ],
        ));
  }
}
