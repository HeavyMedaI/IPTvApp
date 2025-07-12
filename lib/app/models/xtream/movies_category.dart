import 'dart:convert';

List<MovieCategoryModel> moviesCategoryModelListFromJson(dynamic json) {
  if (json is String) {
    return List<MovieCategoryModel>.from(jsonDecode(json)
        .map((movieCategory) => movieCategoryModelFromJson(movieCategory)));
  }
  return json.map((movieCategory) => movieCategoryModelFromJson(movieCategory));
}

String moviesCategoryModelListToJson(List<MovieCategoryModel> categoryList) =>
    jsonEncode(List<String>.from(
        categoryList.map((category) => movieCategoryModelToJson(category))));

MovieCategoryModel movieCategoryModelFromJson(dynamic json) {
  if (json is String) {
    return MovieCategoryModel.fromJson(jsonDecode(json));
  }
  return MovieCategoryModel.fromJson(json);
}

String movieCategoryModelToJson(MovieCategoryModel category) =>
    jsonEncode(category.toJson());

class MovieCategoryModel {
  dynamic id;
  String? categoryId;
  String? categoryName;
  int? parentId;
  int? type;

  // int randomValue;

  MovieCategoryModel(
      {this.id, this.categoryId, this.categoryName, this.parentId, this.type
      // required this.randomValue,
      });

  factory MovieCategoryModel.fromJson(Map<String, dynamic> json) =>
      MovieCategoryModel(
          id: json['id'],
          categoryId: json["category_id"],
          categoryName: json["category_name"],
          parentId: json["parent_id"],
          type: 1
          // randomValue: Random().nextInt(4) + 1,
          );

  Map<String, dynamic> toJson() => {
        'id': id,
        "category_id": categoryId,
        "category_name": categoryName,
        "parent_id": parentId,
        'type': type
        // "random_value": randomValue,
      };
}
