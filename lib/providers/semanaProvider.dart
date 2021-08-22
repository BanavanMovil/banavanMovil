import 'dart:io';

import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/providers/loginProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:banavanmov/exception/customException.dart';
//import 'package:banavanmov/model/lote.dart';

class SemanaProvider {
  final String baseUrl = 'https://coco-backend-api.herokuapp.com/api/semana/';

  //Future<Map<String, List<Semana>>> getAll() async {
  Future<List<Semana>> getAll() async {
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
    //print(responseJson);
    var newResponseJson = responseJson["semanas"];
    //print("\n\n");
    //print(newResponseJson);
    //return SemanaResponse.fromJson(responseJson).results;
    return SemanaResponse.fromJson(newResponseJson).results;
  }

  Future<Map<String, dynamic>> getDateData(String fecha) async {
    var token = await LoginProvider.getToken();
    var responseJson;
    try {
      final resp =
          await http.get(baseUrl + 'getDateData?fecha=' + fecha, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      responseJson = _response(resp);
    } on SocketException {
      throw FetchDataException('Sin Conexion');
    }
    //print(responseJson);
    var newResponseJson = responseJson;
    //print("\n\n");
    print(newResponseJson);
    print("print en el provider" + newResponseJson['id'].toString());
    //return SemanaResponse.fromJson(responseJson).results;c
    return newResponseJson;
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
