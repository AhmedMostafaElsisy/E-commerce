import '../../../../core/Constants/Enums/item_meta_type.dart';

List<ItemMetaDataModel> metaDataListFromJson(List str) =>
    List<ItemMetaDataModel>.from(str.map((x) => ItemMetaDataModel.fromJson(x)));

class ItemMetaDataModel {
  int id;
  String name;
  String image;
  String unite;
  bool showInCard;
  MetaTypes metaType;
  List<dynamic> value;

  ItemMetaDataModel(
      {required this.id,
      required this.name,
      required this.value,
      required this.image,
      required this.showInCard,
      required this.unite,
      required this.metaType});

  factory ItemMetaDataModel.fromJson(Map<String, dynamic> json) {
    return ItemMetaDataModel(
        name: json['name'],
        unite: json['unit']??"",
        id: json['id'],
        value: json['value'] is String ? [json['value']] : json['value'],
        metaType: json['value'] is String ? MetaTypes.single : MetaTypes.multi,
        image: json['image'] ?? '',
        showInCard: json["show_on_first_page"] == null
            ? false
            : json["show_on_first_page"] == 0
                ? false
                : true);
  }
}
