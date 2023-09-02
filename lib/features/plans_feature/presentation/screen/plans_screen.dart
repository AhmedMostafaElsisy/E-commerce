import 'package:captien_omda_customer/features/plans_feature/presentation/logic/plans_cubit.dart';
import 'package:captien_omda_customer/features/plans_feature/presentation/screen/widget/plan_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/Constants/app_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/Helpers/shared.dart';
import '../../../../core/Helpers/shared_texts.dart';
import '../../../../core/presentation/Routes/route_names.dart';
import '../../../../core/presentation/Widgets/common_app_bar_widget.dart';
import '../../../../core/presentation/Widgets/common_empty_widget.dart';
import '../../../../core/presentation/Widgets/common_error_widget.dart';
import '../../../../core/presentation/Widgets/common_loading_widget.dart';
import '../../../../core/presentation/Widgets/common_title_text.dart';
import '../../../../core/presentation/Widgets/custom_snack_bar.dart';
import '../../../../core/presentation/screen/main_app_page.dart';
import '../../../store_feature/presentation/logic/my_stores_cubit/store_cubit.dart';
import '../../../store_feature/presentation/logic/my_stores_cubit/store_states.dart';
import '../logic/plans_states.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  late PlansCubit plansCubit;

  @override
  void initState() {
    super.initState();
    plansCubit = BlocProvider.of<PlansCubit>(context);
    plansCubit.getPlansData();
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
                  textKey: AppLocalizations.of(context)!.lblPricePlan,
                  textColor: AppConstants.lightBlackColor,
                  textWeight: FontWeight.w400,
                  textFontSize: AppConstants.normalFontSize,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getWidgetWidth(AppConstants.pagePadding)),
                child: Column(
                  children: [
                    BlocConsumer<PlansCubit, PlansStates>(
                      listener: (planCtx, planState) {
                        if (planState is PlansErrorState) {
                          checkUserAuth(
                              context: planCtx,
                              errorType: planState.error!.type);
                        }
                      },
                      builder: (storeCtx, storeState) {
                        if (storeState is PlansLoadingState) {
                          return const CommonLoadingWidget();
                        } else if (storeState is PlansErrorState) {
                          return CommonError(
                            errorMassage: storeState.error!.errorMassage,
                            withButton: true,
                            onTap: () => plansCubit.getPlansData(),
                          );
                        } else if (storeCtx
                            .read<PlansCubit>()
                            .planList
                            .isEmpty) {
                          return EmptyScreen(
                              imageString: "category.svg",
                              titleKey:
                                  AppLocalizations.of(context)!.lblNoStoreFound,
                              description: AppLocalizations.of(context)!
                                  .lblNoStoreFoundDesc,
                              imageHeight: 80,
                              withButton: true,
                              buttonText:
                                  AppLocalizations.of(context)!.lblAddStore,
                              onTap: () {
                                plansCubit.getPlansData();
                              },
                              imageWidth: 08);
                        } else {
                          return SizedBox(
                            height: SharedText.screenHeight - 110,
                            child: BlocConsumer<StoreCubit, StoreStates>(
                              listener: (storeCtx, storeState){
                                if (storeState is CreateStoreSuccessStates) {
                                    showSnackBar(
                                        context: storeCtx,
                                        title: AppLocalizations.of(context)!
                                            .lblStoreCreatedSuccess,
                                        color: AppConstants.successColor);
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RouteNames.mainBottomNavPageRoute,
                                          (route) => false,
                                    );
                                  }

                              },
                              builder: (storeCtx, storeState){
                                if(storeState is CreateStoreLoadingStates){
                                  return const CommonLoadingWidget();
                                }
                                return  Column(
                                  children: [
                                    Expanded(
                                        child: ListView.separated(
                                            shrinkWrap: true,
                                            physics: const BouncingScrollPhysics(),
                                            padding: const EdgeInsets.symmetric(horizontal: 2),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  storeCtx
                                                      .read<PlansCubit>()
                                                      .setPlanSelected(storeCtx
                                                      .read<PlansCubit>()
                                                      .planList[index]);
                                                },
                                                child: PlanItem(
                                                  model: storeCtx
                                                      .read<PlansCubit>()
                                                      .planList[index],
                                                  isSelected: storeCtx
                                                      .read<PlansCubit>()
                                                      .selectedPLan ==
                                                      null
                                                      ? false
                                                      : storeCtx
                                                      .read<PlansCubit>()
                                                      .selectedPLan!
                                                      .id ==
                                                      storeCtx
                                                          .read<PlansCubit>()
                                                          .planList[index]
                                                          .id,
                                                  onTap: (){
                                                    storeCtx
                                                        .read<StoreCubit>()
                                                        .createNewStore(planId: storeCtx
                                                        .read<PlansCubit>()
                                                        .planList[index]
                                                        .id);
                                                  },
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return getSpaceHeight(
                                                  AppConstants.smallPadding);
                                            },
                                            itemCount: storeCtx
                                                .read<PlansCubit>()
                                                .planList
                                                .length)),
                                  ],
                                );
                              },

                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
