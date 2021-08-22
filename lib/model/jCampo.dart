class JefeCampoResponse {
  List<JefeCampoModel> results;
  JefeCampoResponse({this.results});

  JefeCampoResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <JefeCampoModel>[];
      json.forEach((v) {
        results.add(new JefeCampoModel.fromJson(v));
      });
    }
  }
}

class JefeCampoModel {
  int id;
  // ignore: non_constant_identifier_names
  int worker_id;
  // ignore: non_constant_identifier_names
  int assigner_id;
  // ignore: non_constant_identifier_names
  int actividad_id;
  // ignore: non_constant_identifier_names
  String fecha_realizacion;
  // ignore: non_constant_identifier_names
  int lote_id;

  JefeCampoModel(
      {this.id,
      // ignore: non_constant_identifier_names
      this.worker_id,
      // ignore: non_constant_identifier_names
      this.assigner_id,
      // ignore: non_constant_identifier_names
      this.actividad_id,
      // ignore: non_constant_identifier_names
      this.fecha_realizacion,
      // ignore: non_constant_identifier_names
      this.lote_id});

  factory JefeCampoModel.fromJson(Map<String, dynamic> json) => JefeCampoModel(
      id: json['id'],
      worker_id: int.parse(json['worker_id']),
      assigner_id: int.parse(json['assigner_id']),
      fecha_realizacion: json['fecha_realizacion'],
      actividad_id: int.parse(json['actividad_id']),
      lote_id: int.parse(json['lote_id']));

  Map<String, dynamic> toJson() => {
        'id': id,
        'worker_id': worker_id,
        'assigner_id': assigner_id,
        'fecha_realizacion': fecha_realizacion,
        'actividad_id': actividad_id,
        'lote_id': lote_id
      };
}
