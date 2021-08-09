import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/exception/customException.dart';

class EnfundadoProvider {
  final String baseUrl = 'http://demo7764382.mockable.io/enfundados/';

  //POST
  Future<bool> postEnfundado(Enfundado enfundado) async {
    final response = await http.post(baseUrl, body: enfundado.toJson());
    final decodeData = json.decode(response.body);

    //print(decodeData);
    return true;
  }

  //PUT
  Future<bool> updateEnfundado(Enfundado enfundado) async {
    final response = await http.put(baseUrl + enfundado.id.toString(),
        body: enfundado.toJson());
    final decodeData = json.decode(response.body);

    //print(decodeData);
    return true;
  }

  Future<List<dynamic>> getAll() async {
    var responseJson;
    try {
      final resp = await http.get(baseUrl);
      responseJson = _response(resp);
    } on SocketException {
      throw FetchDataException('Sin Conexion');
    }
    return responseJson;
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
