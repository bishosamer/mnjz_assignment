import 'package:hive/hive.dart';
import 'package:mnjz_assignment/models/rating_model.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double price;

  @HiveField(3)
  String description;

  @HiveField(4)
  String category;

  @HiveField(5)
  String image;

  @HiveField(6)
  Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json["id"].toString()),
      title: json['title'].toString(),
      price: double.parse(json['price'].toString()),
      description: json['description'].toString(),
      category: json['category'].toString(),
      image: json['image'].toString(),
      rating: Rating.fromJson(json['rating']),
    );
  }
}
