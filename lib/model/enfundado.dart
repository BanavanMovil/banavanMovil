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
  // ignore: non_constant_identifier_names
  int lote_id;
  // ignore: non_constant_identifier_names
  int semana_id;
  // ignore: non_constant_identifier_names
  int user_id;
  String fecha;
  // ignore: non_constant_identifier_names
  int fundas_entregadas;
  int cantidad;

  Enfundado(
      {this.id,
      // ignore: non_constant_identifier_names
      this.lote_id,
      // ignore: non_constant_identifier_names
      this.semana_id,
      // ignore: non_constant_identifier_names
      this.user_id,
      this.fecha,
      // ignore: non_constant_identifier_names
      this.fundas_entregadas,
      this.cantidad});

  factory Enfundado.fromJson(Map<String, dynamic> json) => Enfundado(
      id: json['id'],
      lote_id: int.parse(json['lote_id']),
      semana_id: int.parse(json['semana_id']),
      user_id: int.parse(json['user_id']),
      fecha: json['fecha'],
      fundas_entregadas: int.parse(json['fundas_entregadas']),
      cantidad: int.parse(json['cantidad']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote_id': lote_id,
        'semana_id': semana_id,
        'user_id': user_id,
        'fecha': fecha,
        'fundas_entregadas': fundas_entregadas,
        'cantidad': cantidad
      };
}
