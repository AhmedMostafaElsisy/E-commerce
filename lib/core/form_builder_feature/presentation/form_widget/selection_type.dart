import 'package:flutter/material.dart';
import '../../../Constants/app_constants.dart';
import '../../../Helpers/shared.dart';
import '../../../presentation/Widgets/common_requrid_text_widget.dart';
import '../../../presentation/Widgets/common_title_text.dart';
import '../../domain/model/form_option_model.dart';

class SelectionType extends StatelessWidget {
  final String title;
  final List<FormOptionModel> optionsToSelect;
  final FormOptionModel? selectedItem;
  final Function(FormOptionModel) onItemSelected;
final bool isRequired;
  const SelectionType(
      {Key? key,
      required this.title,
      required this.optionsToSelect,
      this.selectedItem,
        required this.isRequired,
      required this.onItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonRequiredText(
          textKey: title,
          textColor: AppConstants.mainColor,
          textFontSize: AppConstants.mediumFontSize,
          textWeight: FontWeight.w500,
          textAlignment: TextAlign.start,
          isRequired:isRequired ,
        ),

        ///spacer
        getSpaceHeight(AppConstants.pagePadding),
        SizedBox(
          height: getWidgetWidth(40),
          child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onItemSelected(optionsToSelect[index]);
                  },
                  child: Container(
                    height: getWidgetHeight(30),
                    decoration: BoxDecoration(
                        color: selectedItem != null && selectedItem!.id==optionsToSelect[index].id
                            ? AppConstants.lightRedColor
                            : AppConstants.verificationCodeColor,
                        borderRadius: BorderRadius.circular(
                            AppConstants.containerOfListTitleBorderRadius)),
                    padding: EdgeInsets.symmetric(
                        horizontal: getWidgetWidth(AppConstants.pagePadding),
                        vertical: getWidgetWidth(4)),
                    child: Center(
                      child: CommonTitleText(
                        textKey: optionsToSelect[index].name!,
                        textColor: selectedItem != null && selectedItem!.id==optionsToSelect[index].id
                            ? AppConstants.lightWhiteColor
                            : AppConstants.lightRedColor,
                        textFontSize: AppConstants.mediumFontSize,
                        textWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return getSpaceWidth(AppConstants.smallPadding);
              },
              itemCount: optionsToSelect.length),
        )
      ],
    );
  }
}
