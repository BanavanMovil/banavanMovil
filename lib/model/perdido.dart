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
  String lote_id;
  String cantidad;
  String user_id;
  String perdida_motivo_id;
  String semana_id;
  String fecha;
  String semana_perdida;

  Perdido({
    this.id,
    this.lote_id,
    this.cantidad,
    this.user_id,
    this.perdida_motivo_id,
    this.semana_id,
    this.fecha,
    this.semana_perdida,
  });

  factory Perdido.fromJson(Map<String, dynamic> json) => Perdido(
        id: json['id'],
        lote_id: json['lote_id'],
        cantidad: json['cantidad'],
        user_id: json['user_id'],
        perdida_motivo_id: json['perdida_motivo_id'],
        semana_id: json['semana_id'],
        fecha: json['fecha'],
        semana_perdida: json['semana_perdida'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote_id': lote_id,
        'cantidad': cantidad,
        'user_id': user_id,
        'perdida_motivo_id': perdida_motivo_id,
        'semana_id': semana_id,
        'fecha': fecha,
        'semana_perdida': semana_perdida,
      };
}
