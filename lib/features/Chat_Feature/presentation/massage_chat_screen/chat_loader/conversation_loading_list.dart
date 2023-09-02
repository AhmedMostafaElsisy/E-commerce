import 'package:flutter/cupertino.dart';

import '../../../../../core/Constants/app_constants.dart';
import '../../../../../core/Helpers/shared.dart';
import '../../../../../core/presentation/Widgets/common_asset_image_widget.dart';

class ConversationLoaderWidget extends StatelessWidget {
  final int? itemCount;
  final double itemRadius;
  final Widget? separatedWidget;

  const ConversationLoaderWidget(
      {Key? key,
      this.itemCount = 10,
      this.itemRadius = AppConstants.smallRadius,
      this.separatedWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Row(
            children: [
              commonAssetImageWidget(
                imageString: 'loading.gif',
                height: 48,
                width: 48,
                radius: 1000,
                fit: BoxFit.fill,
              ),
              getSpaceWidth(AppConstants.smallRadius),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonAssetImageWidget(
                    imageString: 'loading.gif',
                    height: 18,
                    width: 100,
                    radius: AppConstants.smallRadius,
                    fit: BoxFit.fill,
                  ),
                  getSpaceHeight(AppConstants.containerBorderRadius),
                  commonAssetImageWidget(
                    imageString: 'loading.gif',
                    height: 15,
                    width: 150,
                    radius: AppConstants.smallRadius,
                    fit: BoxFit.fill,
                  ),
                ],
              )
            ],
          );
        },
        separatorBuilder: (context, index) {
          return separatedWidget ?? getSpaceHeight(AppConstants.pagePadding);
        },
        itemCount: itemCount!);
  }
}
