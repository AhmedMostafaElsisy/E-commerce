List<BannerModel> bannerListFromJson(List str) =>
    List<BannerModel>.from(str.map((x) => BannerModel.fromJson(x)));

class BannerModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? url;
  // BannerNavigationType? navigationType;

  BannerModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.url,
    // this.navigationType,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    // BannerNavigationType getRequestStates(String state) {
    //   switch (state.toLowerCase()) {
    //     case "product":
    //       return BannerNavigationType.product;
    //     case "offer":
    //       return BannerNavigationType.offer;
    //     case "store":
    //       return BannerNavigationType.store;
    //
    //     default:
    //       return BannerNavigationType.initial;
    //   }
    // }

    return BannerModel(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      image: json["banner_image"],
      url: json["url"],
      // navigationType: getRequestStates(json["navigation"]),
    );
  }

  @override
  String toString() {
    return 'BannerModel{id: $id, title: $title, description: $description, navigationType: $url,}';
  }
}
