import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:banavanmov/exception/customException.dart';

class JCampoProvider {
  final String baseUrl = "https://api.jsonbin.io/b/60aaf347b2b1d74df21bab8c";

  Future<List<dynamic>> getAll() async {
    var responseJson;
    try {
      final resp = await http.get(baseUrl);
      responseJson = _response(resp);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<bool> postSolicitud() async {
    final resp = await http.post(baseUrl);
    //to do
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
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
