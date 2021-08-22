import 'dart:io';

import 'package:banavanmov/providers/loginProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:banavanmov/exception/customException.dart';
import 'package:banavanmov/model/actividad.dart';

class ActividadProvider {
  final String baseUrl =
      'https://coco-backend-api.herokuapp.com/api/actividad/';

  //GET
  Future<List<Actividad>> getAll() async {
    var token = await LoginProvider.getToken();

    var responseJson;
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
    return ActividadResponse.fromJson(responseJson['Actividades']).results;
  }

  //POST
  Future<bool> createActividad(Actividad actividad) async {
    var token = await LoginProvider.getToken();

    final response = await http.post(baseUrl + "create",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(actividad.toJson()));
    if (response.statusCode == 200) {
      print("Este es el status code: " + response.statusCode.toString());
      print("Actividad Creada");
      return true;
    } else {
      print(response.body);
      print("Este es el status code: " + response.statusCode.toString());
      print("Algo MALO paso");
      return false;
    }
  }

  //DELETE
  Future<bool> deleteActividad(Actividad actividad) async {
    var token = await LoginProvider.getToken();

    final response = await http.delete(
      baseUrl + "delete?nombre=" + actividad.nombre,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
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
