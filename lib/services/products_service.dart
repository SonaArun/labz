import 'dart:convert';

import 'package:http/http.dart' as http;
class ProductService{
  Future<dynamic> getProduct({int limit=0}) async{
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products?limit=$limit'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return('Failed to load products');
    }
  }
}