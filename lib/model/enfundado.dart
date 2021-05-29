import 'dart:convert';

class Enfundado {
  int id;
  int lote;
  int semana;
  String colorCinta;
  String trabajador;
  String fechaEntrega;
  int fundasRecibidas;
  int fundasEntregadas;

  Enfundado(
      {this.id,
      this.lote,
      this.semana,
      this.colorCinta,
      this.trabajador,
      this.fechaEntrega,
      this.fundasRecibidas,
      this.fundasEntregadas});

  factory Enfundado.fromJson(Map<String, dynamic> json) => Enfundado(
      id: json['id'],
      lote: json['lote'],
      semana: json['semana'],
      colorCinta: json['colorCinta'],
      trabajador: json['nombre'],
      fechaEntrega: json['fechaEntrega'],
      fundasRecibidas: json['fundasRecibidas'],
      fundasEntregadas: json['fundasEntregadas']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote': lote,
        'semana': semana,
        'colorCinta': colorCinta,
        'nombre': trabajador,
        'fechaEntrega': fechaEntrega,
        'fundasRecibidas': fundasRecibidas,
        'fundasEntregadas': fundasEntregadas
      };
}
