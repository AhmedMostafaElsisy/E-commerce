import 'package:captien_omda_customer/core/Helpers/shared_texts.dart';
import 'package:captien_omda_customer/features/general_prodcut_feature/presentation/logic/product_list_cubit/product_list_events.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/model/product_model.dart';
import '../../../../../core/product_Feature/domain/use_case/product_use_case.dart';
import 'product_list_states.dart';

class ProductListCubitWithFilter extends Bloc<SearchEvents, ProductListStates> {
  GeneralProductUseCase productUseCase;

  List<ProductModel> products = [];
  TextEditingController searchController = TextEditingController();

  ///pagination
  int page = 1;
  String? searchNameTemp;

  late ScrollController scrollController;

  bool hasMoreData = false;

  ProductListCubitWithFilter(this.productUseCase)
      : super(ProductListInitStates()) {
    ///Search event
    on<SearchClickEvent>(
      (event, emit) async {
        await getProducts(emit: emit);
      },
    );
    on<SearchClearEvent>(
      (event, emit) async {
        print("call init here");
        searchController = TextEditingController();
        emit(ProductListInitStates());
      },
    );
    on<SearchClickWithNameEvent>(
      (event, emit) async {
        await getProducts(emit: emit);
      },

      ///waite 500 mill after user last input then call the func
      transformer: (eventsStream, mapper) => eventsStream
          .debounceTime(const Duration(milliseconds: 500))
          .switchMap(mapper),
    );

    ///Load more data
    on<LoadMoreData>((event, emit) async {
      await setupScrollController(emit: emit);
    });
  }

  getProducts({
    emit,
  }) async {
    hasMoreData = true;
    page = 1;
    emit(ProductListLoadingStates());
    var result = await productUseCase.getProductWithFilterUseCase(
      page: page,
      searchName: searchController.text,
      categories: SharedText.filterModel.categories,
      tags: SharedText.filterModel.tags,
      cityId: SharedText.filterModel.cityId?.id.toString(),
      areaId: SharedText.filterModel.areaId?.id.toString(),
    );

    result.fold(
      (l) => emit(ProductListFailedStates(error: l)),
      (productsList) {
        hasMoreData = productsList.length == 10;

        if (productsList.isEmpty) {
          products.clear();
          emit(ProductListEmptyStates());
        } else {
          products = productsList;
          emit(ProductListSuccessStates());
        }
      },
    );
  }

  Future<void> setupScrollController({
    emit,
  }) async {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! GetMoreProductListLoadingStates && hasMoreData) {
        await whenScrollProductPagination(emit: emit);
      }
    }
  }

  ///get request history pagination
  whenScrollProductPagination({emit}) async {
    emit(GetMoreProductListLoadingStates());
    page = page + 1;
    var result = await productUseCase.getProductWithFilterUseCase(
      page: page,
      searchName: searchController.text,
      categories: SharedText.filterModel.categories,
      tags: SharedText.filterModel.tags,
      cityId: SharedText.filterModel.cityId?.id.toString(),
      areaId: SharedText.filterModel.areaId?.id.toString(),
    );

    result.fold(
      (error) => emit(GetMoreProductListFailedStates(error: error)),
      (data) {
        hasMoreData = data.length == 10;
        products.addAll(data);
        emit(GetMoreProductListSuccessStates());
      },
    );
  }
}
