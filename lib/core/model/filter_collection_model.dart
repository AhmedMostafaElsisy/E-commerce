import 'package:captien_omda_customer/core/location_feature/domain/model/location_area_model.dart';

import '../tags_feature/domain/model/tags_model.dart';
import 'category_model.dart';

class FilterCollectionModel {
  List<CategoryModel> categories = [];
  List<TagsModel> tags = [];
  LocationAreaModel? cityId;
  LocationAreaModel? areaId;

  FilterCollectionModel(
      {required this.categories, required this.tags, this.areaId, this.cityId});

  @override
  String toString() {
    // TODO: implement toString
    return "here is categories ${categories.toString()}, tags ${tags.toString()}, cityId ${cityId.toString()}, areaId ${areaId.toString()}, ";
  }

  clear() {
    categories = [];
    tags = [];
    cityId = null;
    areaId = null;
  }
}
