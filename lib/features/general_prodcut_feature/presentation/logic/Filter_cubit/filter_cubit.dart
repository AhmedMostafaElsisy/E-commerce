import 'package:captien_omda_customer/core/Helpers/shared_texts.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:captien_omda_customer/core/tags_feature/domain/model/tags_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/location_feature/domain/model/location_area_model.dart';
import 'filter_states.dart';

class FilterCubit extends Cubit<FilterStates> {
  FilterCubit() : super(FilterInitStates());

  late TextEditingController userCityController;
  late TextEditingController userAreaController;

  initCubit() {
    selectedCity = SharedText.filterModel.cityId;
    selectedArea = SharedText.filterModel.areaId;
    selectedCategories = [];
    selectedCategories.addAll(SharedText.filterModel.categories);
    selectedTags = [];
    selectedTags.addAll(SharedText.filterModel.tags);
    debugPrint(
        "here is categoryModel ${SharedText.filterModel.cityId.toString()}");
    debugPrint(
        "here is categoryModel ${SharedText.filterModel.areaId.toString()}");
    debugPrint(
        "here is categoryModel ${SharedText.filterModel.categories.toString()}");
    debugPrint(
        "here is categoryModel ${SharedText.filterModel.tags.toString()}");
    userCityController = TextEditingController(text: selectedCity?.name);
    userAreaController = TextEditingController(text: selectedArea?.name);
    emit(FilterInitStates());
  }

  LocationAreaModel? selectedCity;
  LocationAreaModel? selectedArea;
  List<CategoryModel> selectedCategories = [];
  List<TagsModel> selectedTags = [];

  setNewCitySelected(LocationAreaModel model) {
    selectedCity = model;
    selectedArea = null;
    emit(FilterUpdateDataStates());
  }

  setSelectedArea(LocationAreaModel model) {
    selectedArea = model;
    emit(FilterUpdateDataStates());
  }

  setSelectedCategories(CategoryModel categoryModel) {
    debugPrint("here is categoryModel ${categoryModel.toString()}");
    debugPrint("here is categoryModel ${selectedCategories.toString()}");
    if (selectedCategories
        .where((element) => element.id == categoryModel.id)
        .isNotEmpty) {
      selectedCategories
          .removeWhere((element) => element.id == categoryModel.id);
    } else {
      selectedCategories.add(categoryModel);
    }
    debugPrint("here is categoryModel ${selectedCategories.toString()}");

    emit(FilterUpdateDataStates());
  }

  bool checkSelectedCategory(CategoryModel categoryModel) {
    return selectedCategories
        .where((element) => element.id == categoryModel.id)
        .toList()
        .isNotEmpty;
  }

  setSelectedTags(TagsModel tagsModel) {
    debugPrint("here is TagsModel ${tagsModel.toString()}");
    debugPrint("here is TagsModel ${selectedTags.toString()}");
    if (selectedTags
        .where((element) => element.id == tagsModel.id)
        .isNotEmpty) {
      selectedTags.removeWhere((element) => element.id == tagsModel.id);
    } else {
      selectedTags.add(tagsModel);
    }
    emit(FilterUpdateDataStates());
  }

  bool checkSelectedTags(TagsModel tagsModel) {
    return selectedTags
        .where((element) => element.id == tagsModel.id)
        .toList()
        .isNotEmpty;
  }

  apply() {
    SharedText.filterModel.cityId = selectedCity;
    SharedText.filterModel.areaId = selectedArea;
    SharedText.filterModel.categories = selectedCategories;
    SharedText.filterModel.tags = selectedTags;

    emit(FilterSuccessStates());
  }
}
