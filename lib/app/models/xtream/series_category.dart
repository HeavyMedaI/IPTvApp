import 'dart:convert';

List<SeriesCategoryModel> seriesCategoryModelListFromJson(dynamic json) {
  if (json is String) {
    return List<SeriesCategoryModel>.from(jsonDecode(json)
        .map((category) => seriesCategoryModelFromJson(category)));
  }
  return json.map((category) => seriesCategoryModelFromJson(category));
}

String seriesCategoryModelListToJson(List<SeriesCategoryModel> categoryList) =>
    jsonEncode(List<String>.from(
        categoryList.map((category) => seriesCategoryModelToJson(category))));

SeriesCategoryModel seriesCategoryModelFromJson(dynamic json) {
  if (json is String) {
    return SeriesCategoryModel.fromJson(jsonDecode(json));
  }
  return SeriesCategoryModel.fromJson(json);
}

String seriesCategoryModelToJson(SeriesCategoryModel category) =>
    jsonEncode(category.toJson());

class SeriesCategoryModel {
  dynamic id;
  String? categoryId;
  String? categoryName;
  int? parentId;
  int? type;

  SeriesCategoryModel(
      {this.id, this.categoryId, this.categoryName, this.parentId, this.type});

  factory SeriesCategoryModel.fromJson(Map<String, dynamic> json) =>
      SeriesCategoryModel(
          id: json['id'],
          categoryId: json["category_id"],
          categoryName: json["category_name"],
          parentId: json["parent_id"],
          type: 2);

  Map<String, dynamic> toJson() => {
        'id': id,
        "category_id": categoryId,
        "category_name": categoryName,
        "parent_id": parentId,
        'type': type
      };
}
