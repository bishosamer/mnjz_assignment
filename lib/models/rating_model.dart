import 'package:hive/hive.dart';
part 'rating_model.g.dart';

@HiveType(typeId: 1)
class Rating {
  @HiveField(0)
  double rate;

  @HiveField(1)
  int count;

  Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: double.parse(json["rate"].toString()),
      count: int.parse(json["count"].toString()),
    );
  }
}
