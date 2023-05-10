import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
        required this.image,
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.isFavourite,
        required this.isSale,
        this.qty});

  String image;
  String id;
  bool isFavourite;
  bool isSale;
  String name;
  double price;
  String description;

  int? qty;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        isFavourite: false,
        isSale:false,
        qty: json["qty"],
        price: double.parse(json["price"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "isFavourite": isFavourite,
    "isSale": isSale,
        "price": price,
        "qty": qty
      };
  ProductModel copyWith({
    int? qty,
  }) =>
      ProductModel(
        id: id,
        name: name,
        description: description,
        image: image,
        isFavourite: isFavourite,
        isSale:isSale,
        qty: qty ?? this.qty,
        price: price,
      );
}
