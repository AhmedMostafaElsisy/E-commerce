import 'package:flutter/material.dart';

import '../../../../core/Constants/Enums/item_meta_type.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/model/item_meta_data_model.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import 'item_details_widget.dart';
class ProductMetaDataWidget extends StatelessWidget {
  final List<ItemMetaDataModel> metaData;
  const ProductMetaDataWidget({Key? key,required this.metaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemBuilder: (ctx, i) {
            if (metaData[i].metaType ==
                MetaTypes.single) {
              return ItemDetailsWidget(
                  itemDetail: metaData[i]);
            } else {
              return Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [

                  CommonTitleText(
                      textKey: metaData[i].name,
                      textFontSize:
                      AppConstants.mediumFontSize,
                      textAlignment: TextAlign.start,
                      textWeight: FontWeight.w500),

                  ///spacer
                  getSpaceHeight(
                      AppConstants.smallPadding),

                  Wrap(
                    spacing: getWidgetWidth(75),
                    alignment: WrapAlignment.spaceBetween,
                    runSpacing: getWidgetHeight(
                        AppConstants.smallPadding),
                    crossAxisAlignment:
                    WrapCrossAlignment.center,
                    children: metaData[i].value
                        .map((e) => CommonTitleText(
                      textKey: e,
                      textWeight: FontWeight.w400,
                      textColor:
                      AppConstants.mainColor,
                      textAlignment:
                      TextAlign.start,
                    ))
                        .toList(),
                  ),

                ],
              );
            }
          },
          itemCount: metaData.length);
  }
}
