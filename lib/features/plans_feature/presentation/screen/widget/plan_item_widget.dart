import 'package:captien_omda_customer/features/plans_feature/presentation/screen/widget/plan_full_data_widget.dart';
import 'package:captien_omda_customer/features/plans_feature/presentation/screen/widget/plan_short_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../domain/model/plans_model.dart';

class PlanItem extends StatelessWidget {
  final PlansModel model;
  final bool isSelected;
  final Function()onTap;

  const PlanItem({Key? key, required this.model, required this.isSelected,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSelected ?
         PlanFullItemWidget(
            isSelected: isSelected,
            model: model,
           onTap: onTap,
          ) :PlanShortItemWidget(
      model: model,
      isSelected: isSelected,
    )
       ;
  }
}
