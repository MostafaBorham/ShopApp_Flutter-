/////////////////////////Level0
// ignore_for_file: file_names, non_constant_identifier_names

class FavoriteModel {
  bool? status;
  FavoriteDataModel? data;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FavoriteDataModel.fromJson(json['data']);
  }
}

/////////////////////////Level1
class FavoriteDataModel {
  List<FavoriteProductModel> data = [];

  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoriteProductModel.fromJson(element));
    });
  }
}

/////////////////////////Level2
class FavoriteProductModel {
  FavoriteProductDetailModel? product;

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    product = FavoriteProductDetailModel.fromJson(json['product']);
  }
}

/////////////////////////Level3
class FavoriteProductDetailModel {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;

  FavoriteProductDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
