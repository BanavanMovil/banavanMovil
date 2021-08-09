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
  int lote;
  int semana;
  String colorCinta;
  int numRacimos;

  Cosechado(
      {this.id, this.lote, this.semana, this.colorCinta, this.numRacimos});

  factory Cosechado.fromJson(Map<String, dynamic> json) => Cosechado(
      id: json['id'],
      lote: json['lote'],
      semana: json['semana'],
      colorCinta: json['colorCinta'],
      numRacimos: json['numeroRacimos']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote': lote,
        'semana': semana,
        'colorCinta': colorCinta,
        'numeroRacimos': numRacimos
      };
}
