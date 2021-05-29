import 'dart:convert';

class Perdido {
  int id;
  int lote;
  int semana;
  String colorCinta;
  String trabajador;
  String fechaRegistro;
  String motivo;

  Perdido(
      {this.id,
      this.lote,
      this.semana,
      this.colorCinta,
      this.trabajador,
      this.fechaRegistro,
      this.motivo});

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
