//import 'dart:convert';

class CosechadoResponse {
  List<Cosechado> results;
  CosechadoResponse({this.results});

  CosechadoResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <Cosechado>[];
      json.forEach((v) {
        results.add(new Cosechado.fromJson(v));
      });
    }
  }
}

class Cosechado {
  int id;
  String lote_id;
  String cantidad;
  String user_id;
  String semana_id;
  String fecha;
  String semana_cosecha;

  Cosechado({
    this.id,
    this.lote_id,
    this.cantidad,
    this.user_id,
    this.semana_id,
    this.fecha,
    this.semana_cosecha,
  });

  factory Cosechado.fromJson(Map<String, dynamic> json) => Cosechado(
        id: json['id'],
        lote_id: json['lote_id'],
        cantidad: json['cantidad'],
        user_id: json['user_id'],
        semana_id: json['semana_id'],
        fecha: json['fecha'],
        semana_cosecha: json['semana_cosecha'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote_id': lote_id,
        'cantidad': cantidad,
        'user_id': user_id,
        'semana_id': semana_id,
        'fecha': fecha,
        'semana_cosecha': semana_cosecha,
      };
}
