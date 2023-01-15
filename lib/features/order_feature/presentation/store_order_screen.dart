import 'package:captien_omda_customer/features/order_feature/presentation/widget/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Constants/app_constants.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../core/Helpers/shared.dart';
import '../../../core/presentation/Routes/route_argument_model.dart';
import '../../../core/presentation/Routes/route_names.dart';
import '../../../core/presentation/Widgets/common_asset_svg_image_widget.dart';
import '../../../core/presentation/Widgets/common_text_form_field_widget.dart';

class StoreOrderScreen extends StatefulWidget {
  final RouteArgument argument;

  const StoreOrderScreen({Key? key, required this.argument}) : super(key: key);

  @override
  State<StoreOrderScreen> createState() => _StoreOrderScreenState();
}

class _StoreOrderScreenState extends State<StoreOrderScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppConstants.lightWhiteColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MainAppPage(
          screenContent: Column(
            children: [
              CommonAppBar(
                withBack: true,
                appBarBackGroundColor: AppConstants.transparent,
                showBottomIcon: false,
                centerTitle: false,
                titleWidget: CommonTitleText(
                  textKey:
                      "${AppLocalizations.of(context)!.lblOrder} ${widget.argument.shopModel!.name!}",
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.normalFontSize,
                ),
              ),

              ///search
              SizedBox(
                width: getWidgetWidth(343),
                height: getWidgetHeight(36),
                child: CommonTextFormField(
                  controller: searchController,
                  isReadOnly: true,
                  hintKey: AppLocalizations.of(context)!.lblOrderSearch,
                  keyboardType: TextInputType.text,
                  labelHintColor: AppConstants.lightBlackColor,
                  labelHintFontSize: AppConstants.xxSmallFontSize,
                  radius: AppConstants.textFormBorderRadius,
                  withSuffixIcon: true,
                  suffixIcon: SizedBox(
                    width: getWidgetWidth(16),
                    height: getWidgetHeight(16),
                    child: const Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: CommonAssetSvgImageWidget(
                            imageString: "search.svg",
                            height: 16,
                            width: 16,
                            imageColor: AppConstants.mainColor,
                            fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                    return null;
                  },
                ),
              ),

              ///spacer
              getSpaceHeight(AppConstants.pagePadding),
              Expanded(
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidgetWidth(AppConstants.pagePadding),
                        vertical: getWidgetHeight(AppConstants.smallPadding)),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                RouteNames.orderDetailsPageRoute,
                                arguments: RouteArgument());
                          },
                          child: const OrderItem());
                    },
                    separatorBuilder: (context, index) {
                      return getSpaceHeight(AppConstants.pagePadding);
                    },
                    itemCount: 4),
              )
            ],
          ),
        ),
      ),
    );
  }
}
