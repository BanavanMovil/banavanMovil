import 'dart:convert';

class EnfundadoResponse {
  List<Enfundado> results;
  EnfundadoResponse({this.results});

  EnfundadoResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <Enfundado>[];
      json.forEach((v) {
        results.add(new Enfundado.fromJson(v));
      });
    }
  }
}

class Enfundado {
  int id;
  int lote_id;
  int semana_id;
  String user_id;
  String fecha;
  int fundas_entregadas;

  Enfundado(
      {this.id,
      this.lote_id,
      this.semana_id,
      this.user_id,
      this.fecha,
      this.fundas_entregadas});

  factory Enfundado.fromJson(Map<String, dynamic> json) => Enfundado(
      id: json['id'],
      lote_id: json['lote_id'],
      semana_id: json['semana_id'],
      user_id: json['user_id'],
      fecha: json['fecha'],
      fundas_entregadas: json['fundas_entregadas']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote_id': lote_id,
        'semana_id': semana_id,
        'user_id': user_id,
        'fecha': fecha,
        'fundas_entregadas': fundas_entregadas,
      };
}
