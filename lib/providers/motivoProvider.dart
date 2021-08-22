import 'dart:io';

import 'package:banavanmov/model/motivo.dart';
import 'package:banavanmov/providers/loginProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:banavanmov/exception/customException.dart';

class MotivoProvider {
  final String baseUrl =
      'https://coco-backend-api.herokuapp.com/api/perdidaMotivo/';

  Future<List<Motivo>> getAll() async {
    var token = await LoginProvider.getToken();
    var responseJson;
    try {
      final resp = await http.get(baseUrl + 'get', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      responseJson = _response(resp);
    } on SocketException {
      throw FetchDataException('Sin Conexion');
    }

    return MotivoResponse.fromJson(responseJson).results;
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
