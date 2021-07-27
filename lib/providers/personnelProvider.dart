import 'dart:io';

import 'package:banavanmov/model/personnel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:banavanmov/exception/customException.dart';
//import 'package:banavanmov/model/lote.dart';

class PersonnelProvider {
  final String baseUrl =
      'https://coco-backend-api.herokuapp.com/api/personnel/';

  Future<List<Personnel>> getAll() async {
    var responseJson;
    try {
      final resp = await http.get(baseUrl + 'get?isActive=0');
      responseJson = _response(resp);
    } on SocketException {
      throw FetchDataException('Sin Conexion');
    }
    //print(responseJson);
    return PersonnelResponse.fromJson(responseJson).results;
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
