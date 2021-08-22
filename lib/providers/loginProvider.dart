import 'dart:io';
import 'package:flutter_session/flutter_session.dart';
import 'package:banavanmov/response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:banavanmov/exception/customException.dart';

class LoginProvider {
  final String loginUrl =
      'https://coco-backend-api.herokuapp.com/api/authentication/login';

  static final SESSION = new FlutterSession();

  Future<Map<String, dynamic>> login(String user, String pass) async {
    var responseJson;
    var body = {'email': user, 'password': pass};
    try {
      final resp = await http.post(loginUrl,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(body));
      responseJson = _response(resp);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('Sin Conexion');
    }
    //print(responseJson);
    return responseJson;
  }

  static Future setToken(String token) async {
    await SESSION.set('token', token.toString());
  }

  static Future<String> getToken() async {
    return await SESSION.get('token');
  }

  static Future removeToken() async {
    await SESSION.prefs.clear();
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        //print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
