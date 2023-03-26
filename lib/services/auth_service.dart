import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthService {
  Future<dynamic> getTrackers() async {
    Uri url = Uri.parse(
        'https://recursion4-0-backend-server.onrender.com/api/track/getalltrackers');
    var response = await http.post(
      url,
      headers: {"Content_Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Exception in auth Service');
    }
  }
}
