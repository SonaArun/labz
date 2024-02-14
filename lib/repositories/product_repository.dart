import 'package:flutter/material.dart';

import '../services/index.dart';

class ProductRepository extends ChangeNotifier {
  final ProductService productService = ProductService();
  dynamic _products;

  dynamic get products => _products;

  // Function to get product list
  Future<void> getProduct({int limit=0}) async{
    var response = await productService.getProduct(limit:limit);
    try{
      _products = response;
    } catch(e) {
    _products = e;
    } finally{
      notifyListeners();
    }
  }
}