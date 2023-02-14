List<ImageModel> imageListFromJson(List str) =>
    List<ImageModel>.from(str.map((x) => ImageModel.fromJson(x)));

class ImageModel {
  int? id;
  String? imageUrl;
  String? fileImage;

  ImageModel({ this.id,  this.imageUrl,this.fileImage});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(id: json['id'], imageUrl: json['image']);
  }

  @override
  String toString() {
    return 'ImageModel{id: $id, imageUrl: $imageUrl, fileImage: $fileImage}';
  }
}
