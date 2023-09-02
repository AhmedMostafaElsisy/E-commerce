import '../../../../core/Error_Handling/parsing_exceptions.dart';

List<ChatSettingModel> chatSettingListFromJson(List str) =>
    List<ChatSettingModel>.from(str.map((x) => ChatSettingModel.fromJson(x)));

class ChatSettingModel {
  String? name;
  String? key;
  bool? status;

  ChatSettingModel({this.name, this.key, this.status});

  factory ChatSettingModel.fromJson(Map<String, dynamic> json) {
    return ChatSettingModel(
        name: json["name"], status: json["status"], key: json["key"]);
  }

  switchStatusValue() {
    status = !status!;
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "name": name,
        "status": status,
        "key": key,
      };
    } catch (e) {
      throw ParsingException(errorException: e.toString());
    }
  }

  @override
  String toString() {
    return "ChatSettingModel -> name: $name, status: $status, key: $key ";
  }
}
