import 'package:flutter/foundation.dart';

class Product extends ChangeNotifier {
  final int id;
  final String title;
  double price;
  int quantity;
  double total;
  final double discountPercentage;
  final double discountedPrice;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.thumbnail,
  });

  void updateQuantity(int newQuantity) {
    quantity = newQuantity;
    total = quantity * price;
    notifyListeners();
  }
}
