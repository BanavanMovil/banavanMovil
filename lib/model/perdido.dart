import 'dart:convert';

class PerdidoResponse {
  List<Perdido> results;
  PerdidoResponse({this.results});

  PerdidoResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <Perdido>[];
      json.forEach((v) {
        results.add(new Perdido.fromJson(v));
      });
    }
  }
}

class Perdido {
  int id;
  int lote;
  int semana;
  String colorCinta;
  String trabajador;
  String fechaRegistro;
  String motivo;

  Perdido({
    this.id,
    this.lote,
    this.semana,
    this.colorCinta,
    this.trabajador,
    this.fechaRegistro,
    this.motivo,
  });

  factory Perdido.fromJson(Map<String, dynamic> json) => Perdido(
      id: json['id'],
      lote: json['lote'],
      semana: json['semana'],
      colorCinta: json['colorCinta'],
      trabajador: json['nombre'],
      fechaRegistro: json['fechaRegistro'],
      motivo: json['motivo']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote': lote,
        'semana': semana,
        'colorCinta': colorCinta,
        'nombre': trabajador,
        'fechaRegistro': fechaRegistro,
        'motivo': motivo
      };
}
