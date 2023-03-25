import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthService {
  Future<dynamic> getTrackers() async {
    Uri url = Uri.parse(
        'https://recursion4-0-backend-server.onrender.com/api/track/getalltrackers');
    log("above call");
    var response = await http.post(
      url,
      headers: {"Content_Type": "application/json"},
    );

    log("below");

    if (response.statusCode == 200) {
      log(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Exception in auth Service');
    }
  }
}
