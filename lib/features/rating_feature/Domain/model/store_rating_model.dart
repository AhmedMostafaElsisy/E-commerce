
import '../../../../core/model/shop_model.dart';
import '../../../Auth_feature/Data/model/base_user_model.dart';
List<StoreRatingModel> storeRatingModelListFromJson(List str) =>
    List<StoreRatingModel>.from(str.map((x) => StoreRatingModel.fromJson(x)));

class StoreRatingModel {
  int? id;
  int? rate;
  String? comment;
  ShopModel? shopModel;
  UserBaseModel? userModel;

  StoreRatingModel(
      {this.id, this.rate, this.comment, this.shopModel, this.userModel});

factory StoreRatingModel.fromJson(Map<String,dynamic>json){
  return StoreRatingModel(
    id: json["id"]??0,
    comment: json["comment"]??"",
    rate: json["rate"]??0,
    shopModel: ShopModel.fromJson(json["store"]),
    userModel: UserBaseModel.fromJson(json["customer"])
  );
}
}
