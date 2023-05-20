import 'package:flutter/cupertino.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../../core/presentation/Widgets/common_title_text.dart';

class AttachmentItem extends StatelessWidget {
  final String imagePath;
  final String title;
  const AttachmentItem({Key? key, required this.title, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAssetSvgImageWidget(
          imageString: imagePath,
          height: 40,
          width: 40,
          fit: BoxFit.contain,
        ),
        getSpaceHeight(4),
        CommonTitleText(
          textKey: title,
          textWeight: FontWeight.w600,
          textFontSize: 12,
          textColor: AppConstants.mainColor,
        )
      ],
    );
  }
}
