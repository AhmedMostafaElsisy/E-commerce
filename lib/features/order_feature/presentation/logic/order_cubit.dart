import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/model/order_model.dart';
import '../../domain/ues_cases/ues_cases.dart';
import 'order_states.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit(this.uesCase) : super(OrderInitialStates());

  static OrderCubit get(context) => BlocProvider.of(context);
  final OrderUesCase uesCase;

  List<OrderModel> orderLst = [];

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;

  getOrderListData() async {
    emit(OrderLoadingStates());
    page = 1;
    var result = await uesCase.getOrderData(page: page);
    result.fold((error) => emit(OrderFailedStates(error)), (data) {
      orderLst = data;
      if (orderLst.isEmpty) {
        emit(OrderEmptyStates());
      } else {
        emit(OrderSuccessStates());
      }
    });
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! OrderLoadingMoreDataStates && hasMoreData) {
        whenScrollOrderPagination();
      }
    }
  }

  ///get request history pagination
  whenScrollOrderPagination() async {
    emit(OrderLoadingMoreDataStates());
    page = page + 1;
    var result = await uesCase.getOrderData(page: page);

    result.fold(
      (error) => emit(OrderFailedMoreDataStates(error)),
      (data) {
        hasMoreData = data.length == 10;
        orderLst.addAll(data);
        emit(OrderSuccessStates());
      },
    );
  }

}
