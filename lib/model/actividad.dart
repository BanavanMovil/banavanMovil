class ActividadResponse {
  List<Actividad> results;
  ActividadResponse({this.results});

  ActividadResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <Actividad>[];
      json.forEach((v) {
        results.add(new Actividad.fromJson(v));
      });
    }
  }
}

class Actividad {
  int id;
  String nombre;
  Actividad({this.id, this.nombre});

  factory Actividad.fromJson(Map<String, dynamic> json) =>
      Actividad(id: json['id'], nombre: json['titulo']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
      };
}
