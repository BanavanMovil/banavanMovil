import 'package:flutter/foundation.dart';

class SolicitudResponse {
  List<Solicitud> results;
  SolicitudResponse({this.results});

  SolicitudResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <Solicitud>[];
      json.forEach((v) {
        results.add(new Solicitud.fromJson(v));
      });
    }
  }
}

class Solicitud {
  int id;
  // ignore: non_constant_identifier_names
  int user_id;
  // ignore: non_constant_identifier_names
  int solicitud_tipo_id;
  String mensaje;
  // ignore: non_constant_identifier_names
  int personal_requerido;
  // ignore: non_constant_identifier_names
  int lote_id;
  // ignore: non_constant_identifier_names
  String fecha_actividad;
  // ignore: non_constant_identifier_names
  bool is_accepted;
  // ignore: non_constant_identifier_names
  bool is_answered;
  // ignore: non_constant_identifier_names
  bool is_used;
  // ignore: non_constant_identifier_names
  int actividad_id;

  Solicitud(
      {this.id,
      // ignore: non_constant_identifier_names
      this.user_id,
      // ignore: non_constant_identifier_names
      this.solicitud_tipo_id,
      this.mensaje,
      // ignore: non_constant_identifier_names
      this.personal_requerido,
      // ignore: non_constant_identifier_names
      this.lote_id,
      // ignore: non_constant_identifier_names
      this.fecha_actividad,
      // ignore: non_constant_identifier_names
      this.is_accepted,
      // ignore: non_constant_identifier_names
      this.is_answered,
      // ignore: non_constant_identifier_names
      this.is_used,
      // ignore: non_constant_identifier_names
      this.actividad_id});

  factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
      id: json['id'],
      lote_id: int.parse(json['lote_id']),
      solicitud_tipo_id: int.parse(json['solicitud_tipo_id']),
      user_id: int.parse(json['user_id']),
      mensaje: json['mensaje'],
      personal_requerido: int.parse(json['personal_requerido']),
      fecha_actividad: json['fecha_actividad'],
      is_accepted: json['is_accepted'] == "0" ? false : true,
      is_answered: json['is_answered'] == "0" ? false : true,
      is_used: json['is_used'] == "0" ? false : true,
      actividad_id: int.parse(json['actividad_id']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote_id': lote_id,
        'solicitud_tipo_id': solicitud_tipo_id,
        'user_id': user_id,
        'mensaje': mensaje,
        'personal_requerido': personal_requerido,
        'fecha_actividad': fecha_actividad,
        'is_accepted': is_accepted,
        'is_answered': is_answered,
        'is_used': is_used,
        'actividad_id': actividad_id
      };
}
