List<FqaModel> fqaListFromJson(List str) =>
    List<FqaModel>.from(str.map((x) => FqaModel.fromJson(x)));

class FqaModel {
  int? id;
  String? question;
  String? answer;

  FqaModel({this.id, this.question, this.answer});

  factory FqaModel.fromJson(Map<String, dynamic> json) {
    return FqaModel(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}
