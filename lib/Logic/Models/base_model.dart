import 'dart:convert';

BaseModel baseModelFromJson(String str) => BaseModel.fromJson(json.decode(str));

String baseModelToJson(BaseModel data) => json.encode(data.toJson());

class BaseModel {
  BaseModel({
    this.code,
    this.message,
    this.data,
  });

  int? code;

  String? message;
  dynamic data;

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel(
        code: json["code"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data,
      };
}
