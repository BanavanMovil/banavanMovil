import 'package:banavanmov/model/solicitud.dart';
import 'package:banavanmov/providers/actividadProvider.dart';
import 'package:banavanmov/providers/solicitudProvider.dart';

import 'package:banavanmov/response.dart';
import 'package:banavanmov/model/actividad.dart';
import 'dart:async';

class SolicitudRepository {
  SolicitudProvider _provider = SolicitudProvider();

  Future<List<Solicitud>> fetchAllSolicitudes() async {
    final response = await _provider.getAll();
    return response;
  }
}
