class RatingModel{
  int? id;
  String? comment;
  int? rate;

  RatingModel({this.id, this.comment, this.rate});
  factory RatingModel.fromJson(Map<String,dynamic>json){
    return RatingModel(

      id: json["id"],
      comment: json["comment"],
      rate: json["rate"]
    );
  }

  @override
  String toString() {
    return 'RatingModel{id: $id, comment: $comment, rate: $rate}';
  }
}