import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/order_model.dart';
import '../../../domain/ues_cases/ues_cases.dart';
import 'customer_order_states.dart';

class CustomerOrderCubit extends Cubit<CustomerOrderStates> {
  CustomerOrderCubit(this.uesCase) : super(CustomerInitialStates());

  static CustomerOrderCubit get(context) => BlocProvider.of(context);
  final OrderUesCase uesCase;

  List<OrderModel> orderLst = [];

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;

  getCustomerOrders() async {
    emit(CustomerLoadingStates());
    page = 1;
    var result = await uesCase.getOrderData(page: page);
    result.fold((error) => emit(CustomerFailedStates(error)), (data) {
      orderLst = data;
      if (orderLst.isEmpty) {
        emit(CustomerEmptyStates());
      } else {
        emit(CustomerSuccessStates());
      }
    });
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! CustomerLoadingMoreDataStates && hasMoreData) {
        whenScrollOrderPagination();
      }
    }
  }

  ///get request history pagination
  whenScrollOrderPagination() async {
    emit(CustomerLoadingMoreDataStates());
    page = page + 1;
    var result = await uesCase.getOrderData(page: page);

    result.fold(
      (error) => emit(CustomerFailedMoreDataStates(error)),
      (data) {
        hasMoreData = data.length == 10;
        orderLst.addAll(data);
        emit(CustomerSuccessStates());
      },
    );
  }

}
