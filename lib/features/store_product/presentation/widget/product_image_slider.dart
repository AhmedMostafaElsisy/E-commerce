import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';

import '../../../../core/Helpers/shared.dart';
import '../../../../core/model/product_model.dart';

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
        150,
      ),
      child: Stack(
        children: [
          GalleryImage(
            titleGallery: widget.model.name!,
            numOfShowImages: (widget.model.images!.length <= 3)
                ? widget.model.images!.length
                : 3,
            imageUrls:
                widget.model.images!.map((e) => e.imageUrl ?? "").toList(),
          ),
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: Column(
          //     children: [
          //       /// Dots
          //       Container(
          //         padding: const EdgeInsets.symmetric(vertical: 10),
          //         child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: List.generate(
          //               widget.model.images!.length,
          //               (index) => Container(
          //                 margin: const EdgeInsets.symmetric(horizontal: 4),
          //                 width: index == pageViewIndex ? 20 : 13,
          //                 height: 6,
          //                 decoration: BoxDecoration(
          //                   color: index == pageViewIndex
          //                       ? AppConstants.greyColor
          //                       : AppConstants.lightGreyTextColor,
          //                   borderRadius: BorderRadius.circular(
          //                     AppConstants.smallRadius,
          //                   ),
          //                 ),
          //               ),
          //             )),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
