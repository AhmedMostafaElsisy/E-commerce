List<TagsModel> tagsListFromJson(List str) =>
    List<TagsModel>.from(str.map((x) => TagsModel.fromJson(x)));

class TagsModel {
  int? id;
  String? name;
  String? slug;

  TagsModel({
    this.id,
    this.slug,
    this.name,
  });

  factory TagsModel.fromJson(Map<String, dynamic> json) {
    return TagsModel(
      id: json["id"],
      slug: json["slug"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "slug": slug,
      };

  @override
  String toString() {
    return 'TagsModel{id: $id, name: $name, slug: $slug}';
  }
}
