import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Constants/app_constants.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../Profile_feature/presentation/screens/common_profile_header_widget.dart';
import '../../../favorite_feature/presentation/logic/favorite_cubit.dart';
import '../../../favorite_feature/presentation/logic/favorite_states.dart';

class ProductFavoriteButton extends StatelessWidget {
  final ProductModel product;

  const ProductFavoriteButton({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: getWidgetWidth(40),
        height: getWidgetHeight(40),
        decoration: BoxDecoration(
          color: AppConstants.lightGrayColor,
          borderRadius: BorderRadius.circular(
            AppConstants.smallRadius,
          ),
        ),
        child: BlocConsumer<FavoriteCubit, FavoriteStates>(
          listener: (favCtx, favState) {
            if (favState is FavoriteFavFailedStates) {
              showSnackBar(
                context: favCtx,
                title: favState.error.errorMassage!,
              );
            } else if (favState is FavoriteRemoveFavSuccessStates) {
              if (favState.productId == product.id) {
                product.isFav = false;
              }
            } else if (favState is FavoriteAddFavSuccessStates) {
              if (favState.productId == product.id) {
                product.isFav = true;
              }
            }
          },
          builder: (favCtx, favState) {
            if (favState is FavoriteFavLoadingStates &&
                favState.productId == product.id) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: getWidgetHeight(12),
                  width: getWidgetWidth(12),
                  child: const CircularProgressIndicator(
                    color: AppConstants.mainColor,
                  ),
                ),
              );
            }
            return CommonProfileHeaderWidget(
              imagePath: product.isFav! ? "fav_enable.svg" : "fav_disable.svg",
              backGroundColor: AppConstants.transparent,
              imageHeight: 16,
              imageWidth: 16,
              onClick: () {
                if (favState is! FavoriteFavLoadingStates) {
                  product.isFav!
                      ? favCtx
                          .read<FavoriteCubit>()
                          .removeItemFromFav(productId: product.id!)
                      : favCtx
                          .read<FavoriteCubit>()
                          .addItemToFav(productId: product.id!);
                }
              },
            );
          },
        ));
  }
}
