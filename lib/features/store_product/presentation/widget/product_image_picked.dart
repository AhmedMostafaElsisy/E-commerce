import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../../core/presentation/Widgets/common_file_image_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../edit_product_feature/presentation/widget/delete_photo_widget.dart';
import '../logic/product_cubit.dart';
import '../logic/product_states.dart';

class ProductNewImagePicked extends StatefulWidget {
  const ProductNewImagePicked({Key? key}) : super(key: key);

  @override
  State<ProductNewImagePicked> createState() => _ProductNewImagePickedState();
}

class _ProductNewImagePickedState extends State<ProductNewImagePicked> {
  @override
  Widget build(BuildContext context) {
    debugPrint("i'am updating");

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      BlocBuilder<ProductCubit, ProductState>(
          builder: (productCtx, productState) {
        if (productCtx.read<ProductCubit>().imageXFile.isNotEmpty) {
          return SizedBox(
            height: getWidgetHeight(45),
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      deletePhotoFunction(
                          context: context,
                          onDelete: () {
                            BlocProvider.of<ProductCubit>(context)
                                .deletePhoto(index);
                          });
                    },
                    child: commonFileImageWidget(
                      imageString: BlocProvider.of<ProductCubit>(context)
                          .imageXFile[index]
                          .path,
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return getSpaceWidth(AppConstants.smallPadding);
                },
                itemCount:
                    BlocProvider.of<ProductCubit>(context).imageXFile.length),
          );
        } else {
          return CommonTitleText(
            textKey: AppLocalizations.of(context)!.lblAdsImages,
            textWeight: FontWeight.w500,
            textColor: AppConstants.mainColor,
            textFontSize: AppConstants.smallFontSize,
          );
        }
      }),
      const CommonAssetSvgImageWidget(
          imageString: "upload.svg", height: 24, width: 24),
    ]);
  }
}
