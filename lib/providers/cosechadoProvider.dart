import 'package:banavanmov/providers/loginProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:banavanmov/model/cosechado.dart';
import 'dart:io';
import 'package:banavanmov/exception/customException.dart';
import 'package:banavanmov/model/newObject.dart';
import 'package:banavanmov/model/newObjectAR.dart';

class CosechadoProvider {
  //final String url = 'https://api.jsonbin.io/b/60b12ffc893b7c555b1dc945';
  final String url = 'https://coco-backend-api.herokuapp.com/api/cosechado/';

  //POST
  Future<bool> sendCosechado(NewObject newObject) async {
    var token = await LoginProvider.getToken();
    print("Aqui esta el racimo cosechado: " + newObject.toJson().toString());
    final response = await http.post(url + "create",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(newObject.toJson()));
    if (response.statusCode == 201) {
      print("Este es el status code: " + response.statusCode.toString());
      print("Racimo Cosechado Creado");
      return true;
    } else {
      print(response.body);
      print("Este es el status code: " + response.statusCode.toString());
      print("Algo paso");
      return false;
    }
  }

  //PUT
  Future<bool> updateCosechado(NewObjectTwo newObjectt) async {
    var token = await LoginProvider.getToken();
    print("Aqui esta el racimo cosechado: " + newObjectt.toJson().toString());
    final response = await http.put(url + "update",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(newObjectt.toJson()));
    if (response.statusCode == 200) {
      print("Este es el status code: " + response.statusCode.toString());
      print("Racimo Cosechado Actualizado");
      return true;
    } else {
      print(response.body);
      print("Este es el status code: " + response.statusCode.toString());
      print("Algo paso");
      return false;
    }
    /*final response = await http.put(url + newObjectt.id.toString(),
        body: newObjectt.toJson());
    final decodeData = json.decode(response.body);*/

    //print(decodeData);
    //return true;
  }

  Future<List<dynamic>> getAll() async {
    var token = await LoginProvider.getToken();
    var responseJson;
    try {
      final resp = await http.get(url + 'get', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      responseJson = _response(resp);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson["registros"];
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
