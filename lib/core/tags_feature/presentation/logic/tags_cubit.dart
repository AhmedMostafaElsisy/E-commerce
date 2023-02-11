import 'package:captien_omda_customer/core/tags_feature/domain/model/tags_model.dart';
import 'package:flutter/material.dart';
import '../../domain/uesCaes/tags_use_caes.dart';
import 'tags_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagsCubit extends Cubit<TagsLocationStates> {
  TagsCubit(this._locationUesCases) : super(TagsInitStates());

  static TagsCubit get(context) => BlocProvider.of(context);
  final TagsUesCases _locationUesCases;

  ///Tags list data
  List<TagsModel> tagsList = [];
  List<TagsModel> tempTagsList = [];
  TagsModel? selectedTag;

  ///pagination
  int pageNumber = 1;
  late ScrollController cityScrollController;
  bool hasMoreData = false;


  setSelectedTag(TagsModel model) {
    selectedTag = model;
    emit(FilterSearchState());
  }

  ///search in tag list by name
  searchInCityList(String value) {
    tempTagsList = tagsList
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    emit(FilterSearchState());
  }

  ///get tag data
  getTagsData({int limit=10}) async {
    emit(TagsLoadingState());
    pageNumber = 1;
    var result = await _locationUesCases.callTagsList(page: pageNumber,limit: limit);

    result.fold(
      (failure) => emit(TagsErrorState(error: failure)),
      (data) {
        if (data.isEmpty) {
          emit(TagsEmptyState());
        } else {
          hasMoreData = data.length == 10;
          tagsList = data;
          tempTagsList = data;
          emit(TagsSuccessState());
        }
      },
    );
  }

  void setupCityScrollController({required countyId}) {
    if (cityScrollController.offset >
            cityScrollController.position.maxScrollExtent - 200 &&
        cityScrollController.offset >=
            cityScrollController.position.maxScrollExtent) {
      if (state is! TagsLoadingMoreDataState && hasMoreData) {
        whenScrollCountryPagination();
      }
    }
  }

  ///get tag pagination
  whenScrollCountryPagination() async {
    emit(TagsLoadingMoreDataState());
    pageNumber = pageNumber + 1;
    var result = await _locationUesCases.callTagsList(page:  pageNumber);

    result.fold(
      (failure) => emit(TagsErrorMoreDataState(error: failure)),
      (data) {
        hasMoreData = data.length == 10;
        tagsList.addAll(data);
        tempTagsList.addAll(data);
        emit(TagsSuccessState());
      },
    );
  }
}
