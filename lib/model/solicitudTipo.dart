class SolicitudTipoResponse {
  List<SolicitudTipo> results;
  SolicitudTipoResponse({this.results});

  SolicitudTipoResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <SolicitudTipo>[];
      json.forEach((v) {
        results.add(new SolicitudTipo.fromJson(v));
      });
    }
  }
}

class SolicitudTipo {
  int id;
  String titulo;
  String descripcion;

  SolicitudTipo({this.id, this.titulo, this.descripcion});

  factory SolicitudTipo.fromJson(Map<String, dynamic> json) => SolicitudTipo(
      id: json['id'], titulo: json['titulo'], descripcion: json['descripcion']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'descripcion': descripcion,
      };
}
