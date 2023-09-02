List<PlanFeatureModel> plansFeatureListFromJson(List str) =>
    List<PlanFeatureModel>.from(str.map((x) => PlanFeatureModel.fromJson(x)));

class PlanFeatureModel{
  String? features;

  PlanFeatureModel({this.features});
  factory PlanFeatureModel.fromJson(Map<String,dynamic>json){
    return PlanFeatureModel(
      features: json["feature"]
    );
  }

  @override
  String toString() {
    return 'PlanFeatureModel{features: $features}';
  }
}