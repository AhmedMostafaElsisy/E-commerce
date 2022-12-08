class TermsModel {
  String? name;
  String? content;
  int? id;

  TermsModel({this.name, this.content, this.id});

  factory TermsModel.fromJson(Map<String, dynamic> json) {
    return TermsModel(
      id: json['id'],
      name: json['name'],
      content: json['value'],
    );
  }
}
