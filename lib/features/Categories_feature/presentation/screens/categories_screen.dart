import 'package:captien_omda_customer/core/Constants/app_constants.dart';
import 'package:captien_omda_customer/core/Helpers/shared.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/category_grid_item_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_app_bar_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_asset_svg_image_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_error_widget.dart';
import 'package:captien_omda_customer/core/presentation/Widgets/common_title_text.dart';
import 'package:captien_omda_customer/core/presentation/screens/app_main_screen.dart';
import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_cubit.dart';
import 'package:captien_omda_customer/features/Categories_feature/presentation/logic/category_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoriesCubit categoriesCubit;

  @override
  void initState() {
    super.initState();
    categoriesCubit = BlocProvider.of<CategoriesCubit>(context);
    categoriesCubit.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AppMainScreen(
      screen: BlocConsumer<CategoriesCubit, CategoryState>(
          listener: (categoryCtx, categoryState) {},
          builder: (categoryCtx, categoryState) {
            if (categoryState is CategoryLoadingState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(
                      color: AppConstants.mainColor,
                    ),
                  )
                ],
              );
            } else if (categoryState is GetCategoryFailedState) {
              return CommonError(
                errorMassage: categoryState.error.errorMassage,
                withButton: true,
                onTap: () => categoriesCubit.getAllCategories(),
              );
            } else {
              return Scaffold(
                backgroundColor: AppConstants.transparent,
                appBar: CommonAppBar(
                  withBack: false,
                  leadingWidth: getWidgetWidth(16),
                  titleWidget: CommonTitleText(
                    textKey: AppLocalizations.of(context)!.lblCategoriesLabel,
                  ),
                  centerTitle: false,
                  appBarBackGroundColor: AppConstants.transparent,
                  customActionWidget: InkWell(
                    onTap: () {
                      //todo:add navigation to filter feature here
                    },
                    child: const CommonAssetSvgImageWidget(
                      imageString: "filter.svg",
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 74 / 82),
                  itemBuilder: (itemCtx, itemPos) {
                    return CategoryGridItemWidget(
                      categoryModel: categoriesCubit.categories[itemPos],
                    );
                  },
                  itemCount: categoriesCubit.categories.length,
                ),
              );
            }
          }),
    );
  }
}
