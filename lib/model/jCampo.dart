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
  int idTrabajador;
  String nombres;
  String apellidos;
  int lote;
  String fechaLabor;
  String horaInicio;
  String horaFin;

  JefeCampoModel({
    this.idTrabajador,
    this.nombres,
    this.apellidos,
    this.lote,
    this.fechaLabor,
    this.horaInicio,
    this.horaFin,
  });

  factory JefeCampoModel.fromJson(Map<String, dynamic> json) => JefeCampoModel(
      idTrabajador: json['idTrabajador'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      lote: json['lote'],
      fechaLabor: json['fechaLabor'],
      horaInicio: json['horaInicio'],
      horaFin: json['horaFin']);

  Map<String, dynamic> toJson() => {
        'idTrabajador': idTrabajador,
        'nombres': nombres,
        'apellidos': apellidos,
        'lote': lote,
        'fechaLabor': fechaLabor,
        'horaInicio': horaInicio,
        'horaFin': horaFin
      };
}
