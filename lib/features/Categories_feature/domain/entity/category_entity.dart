import 'package:equatable/equatable.dart';

class CategoryEntityModel extends Equatable {
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

  @override
  // TODO: implement props
  List<Object?> get props => [id, slug];
}
