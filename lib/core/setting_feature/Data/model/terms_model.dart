class TermsModel {
  String? terms;

  TermsModel({this.terms});

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(terms: json["settingTerms"] ?? "");
  }
}
