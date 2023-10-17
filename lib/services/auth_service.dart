import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthService {
  Future<dynamic> getTrackers() async {
    try {
      Uri url = Uri.parse(
          'https://codecrush-server.onrender.com/api/transaction/alltransactions');
      var response = await http.get(
        url,
        headers: {"Content_Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
