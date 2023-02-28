class CategoryEntityModel {
  int id;
  String name;
  String image;
  String slug;
  bool active;

  CategoryEntityModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.slug,
      required this.active});
}
