import 'package:flutter/material.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/model/product_model.dart';
import '../../../../core/presentation/Widgets/common_cached_image_widget.dart';

class ProductImageSlider extends StatefulWidget {
  final ProductModel model;

  const ProductImageSlider({Key? key, required this.model}) : super(key: key);

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  final controller = PageController(initialPage: 0);
  late int pageViewIndex;

  setInitialValue() {
    pageViewIndex = controller.initialPage;
  }

  @override
  void initState() {
    super.initState();
    setInitialValue();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getWidgetHeight(
        262,
      ),
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.model.images!.length,
            onPageChanged: (index) {
              setState(() {
                pageViewIndex = index;
              });
            },
            controller: controller,
            itemBuilder: (context, index) {
              return Center(
                child: commonCachedImageWidget(
                    widget.model.images![index].imageUrl!,
                    height: 260,
                    width: SharedText.screenWidth,
                    fit: BoxFit.fill,
                    radius: AppConstants.smallRadius),
              );
            },

          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                /// Dots
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                            (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: index == pageViewIndex ? 20 : 13,
                          height: 6,
                          decoration: BoxDecoration(
                            color: index == pageViewIndex
                                ? AppConstants.greyColor
                                : AppConstants.lightGreyTextColor,
                            borderRadius: BorderRadius.circular(
                              AppConstants.smallRadius,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
