import 'dart:convert';

import 'package:http/http.dart' as http;

class UserService {
  static const String _uri = "challenge.telypay.net";

  static Future<bool> login(String email, String pass) async {
    try {
      // configure http request
      final url = Uri.https(_uri, '/auth/login');
      final body = {"email": email, "password": pass};
      final header = {"Content-Type": "application/json"};

      final response = await http.post(url, body: jsonEncode(body), headers: header);
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      return false;
    }
  }
}
