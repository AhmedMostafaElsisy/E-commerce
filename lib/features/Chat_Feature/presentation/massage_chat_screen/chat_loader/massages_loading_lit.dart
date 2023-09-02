import 'package:flutter/cupertino.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_asset_image_widget.dart';

class MassageLoadingList extends StatelessWidget {
  final int? itemCount;
  final double itemHeight;
  final double itemWidth;
  final double itemRadius;

  const MassageLoadingList({
    Key? key,
    this.itemCount = 15,
    this.itemHeight = 40,
    this.itemWidth = 245,
    this.itemRadius = AppConstants.containerOfListTitleBorderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
            horizontal: getWidgetWidth(AppConstants.pagePadding),
            vertical: getWidgetHeight(AppConstants.pagePaddingDouble)),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: index.isEven
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              commonAssetImageWidget(
                imageString: 'loading.gif',
                height: itemHeight,
                width: itemWidth,
                radius: AppConstants.smallRadius,
                fit: BoxFit.fill,
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return getSpaceHeight(AppConstants.pagePadding);
        },
        itemCount: itemCount!);
  }
}
