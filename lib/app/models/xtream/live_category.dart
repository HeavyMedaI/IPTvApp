import 'dart:convert';

List<LiveCategoryModel> liveCategoryModelListFromJson(dynamic json) {
  if (json is String) {
    return List<LiveCategoryModel>.from(jsonDecode(json)
        .map((category) => liveCategoryModelFromJson(category)));
  }
  return json.map((category) => liveCategoryModelFromJson(category));
}

String liveCategoryModelListToJson(List<LiveCategoryModel> categoryList) =>
    jsonEncode(List<String>.from(
        categoryList.map((category) => liveCategoryModelToJson(category))));

LiveCategoryModel liveCategoryModelFromJson(dynamic json) {
  if (json is String) {
    return LiveCategoryModel.fromJson(jsonDecode(json));
  }
  return LiveCategoryModel.fromJson(json);
}

String liveCategoryModelToJson(LiveCategoryModel category) =>
    jsonEncode(category.toJson());

class LiveCategoryModel {
  String? categoryId;
  String? categoryName;
  int? parentId;
  dynamic id;
  int? type;

  LiveCategoryModel(
      {this.categoryId, this.categoryName, this.parentId, this.id, this.type});

  factory LiveCategoryModel.fromJson(Map<String, dynamic> json) =>
      LiveCategoryModel(
          id: json['id'],
          categoryId: json["category_id"],
          categoryName: json["category_name"],
          parentId: json["parent_id"],
          type: 3);

  Map<String, dynamic> toJson() => {
        'id': id,
        "category_id": categoryId,
        "category_name": categoryName,
        "parent_id": parentId,
        'type': type
      };
}
