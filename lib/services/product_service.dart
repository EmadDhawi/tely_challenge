import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String _uri = "challenge.telypay.net";

  static Future<List> getProducts() async {
    try {
      final url = Uri.https(_uri, '/product/all');
      // send request to the server to get list of products
      final response = await http.get(url, headers: {"Content-Type": "application/json"});
      // check that the status code of response is OK [200] else throw exception
      if (response.statusCode != 200) throw "not valid response | ${response.statusCode}";
      // return the list of json
      return jsonDecode(utf8.decode(response.bodyBytes)) as List;
    } catch (e) {
      throw "getting products from the server error | $e";
    }
  }
}
