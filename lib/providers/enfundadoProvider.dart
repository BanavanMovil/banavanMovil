import 'dart:io';
import 'package:banavanmov/providers/loginProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/enfundado.dart';
import 'package:banavanmov/exception/customException.dart';

class EnfundadoProvider {
  final String baseUrl =
      'https://coco-backend-api.herokuapp.com/api/enfundado/';

  //POST
  Future<bool> postEnfundado(Enfundado enfundado) async {
    print("Aqui esta la enfundado:" + enfundado.toJson().toString());
    var token = await LoginProvider.getToken();
    final response = await http.post(baseUrl + 'create',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(enfundado.toJson()));
    final decodeData = json.decode(response.body);

    print(decodeData);
    print("Status code: " + response.statusCode.toString());
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  //PUT
  Future<bool> updateEnfundado(Enfundado enfundado) async {
    print("Aqui esta la enfundado:" + enfundado.toJson().toString());
    var token = await LoginProvider.getToken();
    final response = await http.put(baseUrl + 'update',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(enfundado.toJson()));
    final decodeData = json.decode(response.body);

    print(decodeData);
    return true;
  }

  Future<List<Enfundado>> getAll() async {
    var responseJson;
    var token = await LoginProvider.getToken();
    try {
      final resp = await http.get(baseUrl + 'get', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      responseJson = _response(resp);
      //print(responseJson);
    } on SocketException {
      throw FetchDataException('Sin Conexion');
    }
    return EnfundadoResponse.fromJson(responseJson['registros']).results;
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
