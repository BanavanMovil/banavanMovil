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
  int user_id;
  int solicitud_tipo_id;
  String mensaje;
  int personal_requerido;
  int lote_id;
  String fecha_actividad;
  bool is_accepted;
  bool is_answered;
  bool is_used;
  int actividad_id;

  Solicitud(
      {this.id,
      this.user_id,
      this.solicitud_tipo_id,
      this.mensaje,
      this.personal_requerido,
      this.lote_id,
      this.fecha_actividad,
      this.is_accepted,
      this.is_answered,
      this.is_used,
      this.actividad_id});

  factory Solicitud.fromJson(Map<String, dynamic> json) => Solicitud(
      id: json['id'],
      lote_id: json['lote_id'],
      solicitud_tipo_id: json['solicitud_tipo_id'],
      user_id: json['user_id'],
      mensaje: json['mensaje'],
      personal_requerido: json['personal_requerido'],
      fecha_actividad: json['fecha_actividad'],
      is_accepted: json['is_accepted'],
      is_answered: json['is_answered'],
      is_used: json['is_used'],
      actividad_id: json['actividad_id']);

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
