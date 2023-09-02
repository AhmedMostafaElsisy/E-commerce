import 'package:flutter/material.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/model/item_meta_data_model.dart';

class ItemDetailsWidget extends StatelessWidget {
final  ItemMetaDataModel itemDetail;
 const  ItemDetailsWidget({Key? key, required this.itemDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///detailTitle
            CommonTitleText(
              textKey: itemDetail.name,
              textWeight: FontWeight.w400,
              textColor: AppConstants.mainColor,
              textAlignment: TextAlign.start,
            ),

            ///detailValue
            CommonTitleText(
              textKey: itemDetail.value[0],
              textWeight: FontWeight.w500,
              minTextFontSize: AppConstants.smallFontSize,
              textColor: AppConstants.borderInputColor,
              textAlignment: TextAlign.start,
            ),
          ],
        ),

      ],
    );
  }
}
