import 'package:captien_omda_customer/core/Constants/app_constants.dart';
import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_cached_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:flutter/material.dart';

class CategoryGridItemWidget extends StatelessWidget {
  final CategoryModel categoryModel;

  const CategoryGridItemWidget({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        commonCachedImageWidget(
          categoryModel.image,
          height: 52,
          width: 52,
          fit: BoxFit.contain,
          radius: 1000,
          isCircular: true,

        ),
        getSpaceHeight(12),
        CommonTitleText(
          textKey: categoryModel.name,
          textFontSize: AppConstants.xSmallFontSize,
          textWeight: FontWeight.w500,
          textColor: AppConstants.mainColor,
        )
      ],
    );
  }
}
