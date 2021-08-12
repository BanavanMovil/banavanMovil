class SemanaResponse {
  //Map<String, List<Semana>> results;
  List<Semana> results;
  SemanaResponse({this.results});

  SemanaResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      //results["semanas"] = <Semana>[];
      results = <Semana>[];
      json.forEach((v) {
        //results["semanas"].add(new Semana.fromJson(v));
        results.add(new Semana.fromJson(v));
      });
    }
  }
}

class Semana {
  int id;
  String numero;
  String anho;
  String color_id;

  Semana({
    this.id,
    this.numero,
    this.anho,
    this.color_id,
  });

  factory Semana.fromJson(Map<String, dynamic> json) => Semana(
        id: json['id'],
        numero: json['numero'],
        anho: json['anho'],
        color_id: json['color_id'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'numero': numero,
        'anho': anho,
        'color_id': color_id,
      };
}
