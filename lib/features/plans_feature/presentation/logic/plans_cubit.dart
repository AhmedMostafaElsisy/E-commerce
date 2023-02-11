import 'package:captien_omda_customer/features/plans_feature/domain/model/plans_model.dart';
import '../../domain/uesCaes/plans_use_caes.dart';
import 'plans_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlansCubit extends Cubit<PlansStates> {
  PlansCubit(this._plansUesCases) : super(PlansInitStates());

  static PlansCubit get(context) => BlocProvider.of(context);
  final PlansUesCases _plansUesCases;

  ///plans list data
  List<PlansModel> planList = [];
  PlansModel? selectedPLan;

  setPlanSelected(model) {
    selectedPLan = model;
    emit(PlansSelectedState());
  }

  ///get plans data
  getPlansData({int limit = 10}) async {
    emit(PlansLoadingState());

    var result = await _plansUesCases.callPlansList();

    result.fold(
      (failure) => emit(PlansErrorState(error: failure)),
      (data) {
        if (data.isEmpty) {
          emit(PlansEmptyState());
        } else {
          planList = data;
          selectedPLan = null;
          emit(PlansSuccessState());
        }
      },
    );
  }
}
