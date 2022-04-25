/////////////////////////Level0
// ignore_for_file: file_names

class SearchModel {
  bool? status;
  SearchDataModel? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

/////////////////////////Level1
class SearchDataModel {
  List<SearchItemModel> data = [];

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(SearchItemModel.fromJson(element));
    });
  }
}

/////////////////////////Level2
class SearchItemModel {
  int? id;
  dynamic price;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  SearchItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
