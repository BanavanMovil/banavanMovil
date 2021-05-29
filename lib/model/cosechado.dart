import 'dart:convert';

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
