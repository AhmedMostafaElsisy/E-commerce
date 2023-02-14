import 'package:captien_omda_customer/features/Home_feature/Data/model/banner_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/use_cases/home_use_case.dart';
import 'home_states.dart';

class BannersCubit extends Cubit<HomeState> {
  BannersCubit(this._homeUesCase) : super(HomeInitialState());
  final HomeUesCases _homeUesCase;

  static BannersCubit get(context) => BlocProvider.of(context);
  late List<BannerModel> banners;

  ///get home screen requests
  getBanners() async {
    emit(HomeContentLoadingState());
    var result = await _homeUesCase.callHomeContent();

    result.fold(
      (failure) => emit(HomeGetContentFailedState(failure.error)),
      (useCasHomeContent) {
        banners = useCasHomeContent;
        emit(HomeGetContentSuccessState(useCasHomeContent));
      },
    );
  }
}
