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
  int lote_id;
  int cantidad;
  int user_id;
  int perdida_motivo_id;
  int semana_id;
  String fecha;

  Perdido({
    this.id,
    this.lote_id,
    this.cantidad,
    this.user_id,
    this.perdida_motivo_id,
    this.semana_id,
    this.fecha,
  });

  factory Perdido.fromJson(Map<String, dynamic> json) => Perdido(
        id: json['id'],
        lote_id: json['lote_id'],
        cantidad: json['cantidad'],
        user_id: json['user_id'],
        perdida_motivo_id: json['perdida_motivo_id'],
        semana_id: json['semana_id'],
        fecha: json['fecha'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote_id': lote_id,
        'cantidad': cantidad,
        'user_id': user_id,
        'perdida_motivo_id': perdida_motivo_id,
        'semana_id': semana_id,
        'fecha': fecha,
      };
}
