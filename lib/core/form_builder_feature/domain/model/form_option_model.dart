List<FormOptionModel> formOptionBuilderListFromJson(List str) =>
    List<FormOptionModel>.from(str.map((x) => FormOptionModel.fromJson(x)));

class FormOptionModel {
  int? id;
  int? filedId;
  int? parentId;
  String? name;
  String? key;
  String? type;

  FormOptionModel({this.id, this.filedId, this.name, this.key,this.parentId,this.type});

  factory FormOptionModel.fromJson(Map<String, dynamic> json) {
    return FormOptionModel(
        id: json["id"],
        filedId: json["field_id"],
        key: json["key"],
        parentId: json["parent_id"]??0,
        name: json["label"],
        type: json["type"]
    );
  }

  @override
  String toString() {
    return 'FormOptionModel{id: $id, filedId: $filedId, parentId: $parentId, name: $name, key: $key, type: $type}';
  }
}
