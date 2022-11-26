import 'package:flutter/material.dart';
import '../../Data/Models/faq_model.dart';
import '../../core/Helpers/shared.dart';
import '../../core/Constants/app_constants.dart';
import 'common_title_text.dart';

class CommonFqa extends StatefulWidget {
  final FqaModel model;
  final bool isExpanded;
  final Function()? onPressedFunction;

  const CommonFqa({
    Key? key,
    required this.model,
    this.isExpanded = true,
    this.onPressedFunction,
  }) : super(key: key);

  @override
  State<CommonFqa> createState() => _CommonFqaState();
}

class _CommonFqaState extends State<CommonFqa> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressedFunction,
      child: Container(
        decoration: BoxDecoration(
            color: AppConstants.lightWhiteColor,
            borderRadius: BorderRadius.circular(_customTileExpanded ? 16 : 6)),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
            horizontal: getWidgetWidth(16),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: CommonTitleText(
                  textKey: widget.model.question!,
                  textWeight: FontWeight.w400,
                  textFontSize: 11,
                  lines: 50,
                  textColor: AppConstants.mainColor,
                  textOverflow: TextOverflow.ellipsis,textAlignment: TextAlign.start,
                ),
              ),
            ],
          ),
          textColor: AppConstants.lightBlackColor,
          collapsedTextColor: AppConstants.darkOffWhiteColor,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _customTileExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppConstants.arrowIconColor,
              ),
            ],
          ),
          children: <Widget>[
            widget.isExpanded
                ? FittedBox(
                    child: Column(
                      children: [
                        Container(

                          padding: EdgeInsets.symmetric(
                              horizontal: getWidgetHeight(28)),
                          width: getWidgetWidth(375),
                          decoration: BoxDecoration(
                              color: AppConstants.lightWhiteColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: CommonTitleText(
                                  textKey: widget.model.answer!,
                                  textWeight: FontWeight.w400,
                                  textFontSize: 11,
                                  lines: 50,
                                  textColor:
                                      AppConstants.greyColor,
                                  textOverflow: TextOverflow.ellipsis,textAlignment: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
          onExpansionChanged: (bool expanded) {
            setState(() => _customTileExpanded = expanded);
          },
        ),
      ),
    );
  }
}
