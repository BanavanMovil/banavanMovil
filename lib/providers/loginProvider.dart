import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider {
  final String url = "http://demo7764382.mockable.io/login/";

  login(dynamic data) async {
    return await http.post(url, body: data);
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
