import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/enitiy/home_model.dart';
import '../../../Domain/use_cases/request_use_case.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeUesCase) : super(HomeInitialState());
  final HomeUesCases _homeUesCase;

  static HomeCubit get(context) => BlocProvider.of(context);
  late HomeModel homeContent;

  ///get home screen requests
  getHomeContent() async {
    emit(HomeContentLoadingState());
    var result = await _homeUesCase.callHomeContent();

    result.fold(
      (failure) => emit(HomeGetContentFailedState(failure.error)),
      (useCasHomeContent) {
        homeContent = useCasHomeContent;
        emit(HomeGetContentSuccessState(useCasHomeContent));
      },
    );
  }
}
