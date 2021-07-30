import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:banavanmov/exception/customException.dart';
import 'package:banavanmov/model/solicitud.dart';

class SolicitudProvider {
  final String baseUrl =
      'https://coco-backend-api.herokuapp.com/api/solicitud/';
  //GET
  Future<List<Solicitud>> getAll() async {
    var responseJson;
    try {
      final resp = await http.get(baseUrl + 'get');
      responseJson = _response(resp);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('Sin Conexion');
    }
    return SolicitudResponse.fromJson(responseJson).results;
  }

  //POST
  Future<bool> sendSolicitud(Solicitud solicitud) async {
    //TODO
    return true;
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
