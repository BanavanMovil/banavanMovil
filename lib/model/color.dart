class ColourResponse {
  List<Colour> results;
  ColourResponse({this.results});

  ColourResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <Colour>[];
      json.forEach((v) {
        results.add(new Colour.fromJson(v));
      });
    }
  }
}

class Colour {
  int id;
  String nombre;
  String hex_code;
  String numero;

  Colour({
    this.id,
    this.nombre,
    this.hex_code,
    this.numero,
  });

  factory Colour.fromJson(Map<String, dynamic> json) => Colour(
        id: json['id'],
        nombre: json['nombre'],
        hex_code: json['hex_code'],
        numero: json['numero'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'hex_code': hex_code,
        'numero': numero,
      };
}
