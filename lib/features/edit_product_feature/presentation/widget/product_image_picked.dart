import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/presentation/Widgets/common_cached_image_widget.dart';
import '../../../../core/presentation/Widgets/common_file_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../logic/edit_product/edit_product_cubit.dart';
import 'delete_photo_widget.dart';

class ProductImagePicked extends StatelessWidget {
   ProductImagePicked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      if (BlocProvider.of<EditProductCubit>(context)
          .selectedProduct
          .images!
          .isNotEmpty)
        SizedBox(
          height: getWidgetHeight(45),
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if (BlocProvider.of<EditProductCubit>(context)
                        .selectedProduct
                        .images![index]
                        .fileImage !=
                    null) {
                  return InkWell(
                    onTap: (){
                      deletePhotoFunction(
                          context: context,
                          onDelete: () {
                            BlocProvider.of<EditProductCubit>(context).deletePhoto(index);
                          });

                    },
                    child: commonFileImageWidget(
                      imageString: BlocProvider.of<EditProductCubit>(context)
                          .selectedProduct
                          .images![index]
                          .fileImage!,
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: (){
                      deletePhotoFunction(
                          context: context,
                          onDelete: () {
                            BlocProvider.of<EditProductCubit>(context).deletePhoto(index);
                          });
                    },
                    child: commonCachedImageWidget(
                        BlocProvider.of<EditProductCubit>(context)
                            .selectedProduct
                            .images![index]
                            .imageUrl!,
                        fit: BoxFit.fill,
                        height: 40,
                        width: 40),
                  );
                }
              },
              separatorBuilder: (context, index) {
                return getSpaceWidth(AppConstants.smallPadding);
              },
              itemCount: BlocProvider.of<EditProductCubit>(context)
                  .selectedProduct
                  .images!
                  .length),
        )
      else
        CommonTitleText(
          textKey: AppLocalizations.of(context)!.lblAdsImages,
          textWeight: FontWeight.w500,
          textColor: AppConstants.mainColor,
          textFontSize: AppConstants.smallFontSize,
        ),
      const CommonAssetSvgImageWidget(
          imageString: "upload.svg", height: 24, width: 24),
    ]);
  }
}
