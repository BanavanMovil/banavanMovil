class LoteResponse {
  List<Lote> results;
  LoteResponse({this.results});

  LoteResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <Lote>[];
      json.forEach((v) {
        results.add(new Lote.fromJson(v));
      });
    }
  }
}

class Lote {
  int id;
  int numero;
  int superficie;

  Lote({
    this.id,
    this.numero,
    this.superficie,
  });

  factory Lote.fromJson(Map<String, dynamic> json) => Lote(
        id: json['id'],
        numero: int.parse(json['numero']),
        superficie: int.parse(json['superficie']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'numero': numero,
        'superficie': superficie,
      };
}
