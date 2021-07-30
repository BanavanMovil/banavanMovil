import 'package:banavanmov/providers/actividadProvider.dart';

import 'package:banavanmov/response.dart';
import 'package:banavanmov/model/actividad.dart';
import 'dart:async';

class ActividadRepository {
  ActividadProvider _provider = ActividadProvider();

  Future<List<Actividad>> fetchAllActividades() async {
    final response = await _provider.getAll();
    return response;
  }
}
