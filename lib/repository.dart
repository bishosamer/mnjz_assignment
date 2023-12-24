import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mnjz_assignment/models/product_model.dart';

class Repository {
  static final Repository _instance = Repository._internal();
  factory Repository() => _instance;

  Repository._internal();
  final String apiUrl = 'https://fakestoreapi.com/products';
  final String _productBoxName = 'products';

  Future<List<Product>> fetchProducts() async {
    final box = await Hive.openBox<Product>(_productBoxName);

    if (box.isNotEmpty) {
      return box.values.toList();
    } else {
      try {
        final response = await http.get(Uri.parse(apiUrl));

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body);
          final List<Product> products = jsonData.map((item) {
            final product = Product.fromJson(item);
            box.add(product);
            return product;
          }).toList();

          return products;
        } else {
          throw Exception('Failed to fetch products ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to fetch products: $e');
      }
    }
  }
}
