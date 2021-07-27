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

  Semana({
    this.id,
    this.numero,
    this.anho,
  });

  factory Semana.fromJson(Map<String, dynamic> json) => Semana(
        id: json['id'],
        numero: json['numero'],
        anho: json['anho'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'numero': numero,
        'anho': anho,
      };
}
