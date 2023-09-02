import 'package:flutter_bloc/flutter_bloc.dart';
import 'bottom_nav_cubit_state.dart';

class BottomNavCubit extends Cubit<BottomNavCubitState> {
  BottomNavCubit() : super(BottomNavInitialState());

  static BottomNavCubit get(context) => BlocProvider.of(context);
  int selectedIndex = 0;

  selectItem(int index) {
    selectedIndex = index;
    emit(BottomNavChangeState());
  }
}
