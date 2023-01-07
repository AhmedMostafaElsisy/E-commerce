import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:flutter/material.dart';

import '../../Domain/enitiy/banner_model.dart';

class BannerCarouselWidget extends StatefulWidget {
  final List<BannerModel> banners;

  const BannerCarouselWidget({Key? key, required this.banners})
      : super(key: key);

  @override
  State<BannerCarouselWidget> createState() => _BannerCarouselWidgetState();
}

class _BannerCarouselWidgetState extends State<BannerCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (itemCtx, itemPos) {
        return SizedBox(
          width: getWidgetWidth(343),
          height: getWidgetHeight(132),
          child: Stack(
            children: const [
              Center(
                child: CommonAssetSvgImageWidget(
                  imageString: 'banner.svg',
                  height: 132,
                  width: 343,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 4,
    );
  }
}
