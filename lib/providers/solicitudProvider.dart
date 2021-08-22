import 'dart:io';

import 'package:banavanmov/providers/loginProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:banavanmov/exception/customException.dart';
import 'package:banavanmov/model/solicitud.dart';

class SolicitudProvider {
  final String baseUrl =
      'https://coco-backend-api.herokuapp.com/api/solicitud/';
  //GET
  Future<List<Solicitud>> getAll() async {
    var token = await LoginProvider.getToken();
    var responseJson;
    try {
      final resp = await http.get(baseUrl + 'get', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      responseJson = _response(resp);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('Sin Conexion');
    }
    return SolicitudResponse.fromJson(responseJson['solicitudes']).results;
  }

  //POST
  Future<bool> sendSolicitud(Solicitud solicitud) async {
    print("Aqui esta la solicitud:" + solicitud.toJson().toString());
    var token = await LoginProvider.getToken();
    final response = await http.post(baseUrl + "create",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(solicitud.toJson()));
    if (response.statusCode == 201) {
      print("Este es el status code: " + response.statusCode.toString());
      print("Solicitud Creada");
      return true;
    } else {
      print(response.body);
      print("Este es el status code: " + response.statusCode.toString());
      print("Algo paso");
      return false;
    }
  }

  //POST USER ACTIVIDAD
  Future<bool> sendTrabajadores(Solicitud s, List<int> personal) async {
    var token = await LoginProvider.getToken();
    final response = await http.post(
        'https://coco-backend-api.herokuapp.com/api/userActividad/register',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({'solicitud_id': s.id, 'workers': personal}));
    print(s.id);
    if (response.statusCode == 200) {
      print("Este es el status code: " + response.statusCode.toString());
      print("Trabajadores Enviados");
      return true;
    } else {
      print(response.body);
      print("Este es el status code: " + response.statusCode.toString());
      print("Algo paso");
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
