class MotivoResponse {
  //Map<String, List<Semana>> results;
  List<Motivo> results;
  MotivoResponse({this.results});

  MotivoResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <Motivo>[];
      json.forEach((v) {
        results.add(new Motivo.fromJson(v));
      });
    }
  }
}

class Motivo {
  int id;
  String titulo;
  String descripcion;

  Motivo({
    this.id,
    this.titulo,
    this.descripcion,
  });

  factory Motivo.fromJson(Map<String, dynamic> json) => Motivo(
        id: json['id'],
        titulo: json['titulo'],
        descripcion: json['descripcion'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'titulo': titulo,
        'descripcion': descripcion,
      };
}
