import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_cached_image_widget.dart';
import 'package:captien_omda_customer/features/Home_feature/Data/model/banner_model.dart';
import 'package:flutter/material.dart';

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
            children: [
              Center(
                child: commonCachedImageWidget(
                  widget.banners[itemPos].image ?? "",
                  height: 132,
                  width: 343,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
      itemCount: widget.banners.length,
    );
  }
}
