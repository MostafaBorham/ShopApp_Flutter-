/////////////////////////Level0
// ignore_for_file: file_names

class CategoryModel {
  bool? status;
  CategoryDataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJson(json['data']);
  }
}

/////////////////////////Level1
class CategoryDataModel {
  List<CategoryDetailDataModel> data = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(CategoryDetailDataModel.fromJson(element));
    });
  }
}

/////////////////////////Level2
class CategoryDetailDataModel {
  String? name;
  String? image;

  CategoryDetailDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
}
