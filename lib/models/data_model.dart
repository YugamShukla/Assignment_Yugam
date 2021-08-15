import 'model.dart';

class ProductModel extends Model {
  static String table = 'products';

  int id;
  String movieName;

  String directorName;
  double price;
  String productPic;

  ProductModel({
    this.id,
    this.movieName,
    this.directorName,
    this.price,
    this.productPic,
  });

  static ProductModel fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"],
      movieName: map['productName'].toString(),
      directorName: map['productDesc'],
      price: map['price'],
      productPic: map['productPic'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'productName': movieName,
      'productDesc': directorName,
      'price': price,
      'productPic': productPic
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
