class Semana {
  int id;
  int numero;
  int anho;
  String fecha_inicio;
  int color_id;

  Semana({this.id, this.numero, this.anho, this.fecha_inicio, this.color_id});

  factory Semana.fromJson(Map<String, dynamic> json) => Semana(
        id: json['id'],
        numero: json['numero'],
        anho: json['anho'],
        fecha_inicio: json['fecha_inicio'],
        color_id: json['color_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'numero': numero,
        'anho': anho,
        'fecha_inicio': fecha_inicio,
        'color_id': color_id
      };
}
