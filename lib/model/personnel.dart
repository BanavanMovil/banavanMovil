class PersonnelResponse {
  List<Personnel> results;
  PersonnelResponse({this.results});

  PersonnelResponse.fromJson(List<dynamic> json) {
    if (json.isNotEmpty) {
      results = <Personnel>[];
      json.forEach((v) {
        results.add(new Personnel.fromJson(v));
      });
    }
  }
}

class Personnel {
  int id;
  String nombres;
  String apellidos;
  String email;
  String username;
  String cedula;
  String rol;
  String activo;

  Personnel({
    this.id,
    this.nombres,
    this.apellidos,
    this.email,
    this.username,
    this.cedula,
    this.rol,
    this.activo,
  });

  factory Personnel.fromJson(Map<String, dynamic> json) => Personnel(
        id: json['id'],
        nombres: json['nombres'],
        apellidos: json['apellidos'],
        email: json['email'],
        username: json['username'],
        cedula: json['cedula'],
        rol: json['rol'],
        activo: json['activo'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombres': nombres,
        'apellidos': apellidos,
        'email': email,
        'username': username,
        'cedula': cedula,
        'rol': rol,
        'activo': activo,
      };
  @override
  toString() {
    return "ID:" + id.toString() + " Nombre: " + nombres + " " + apellidos;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Personnel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nombres == other.nombres &&
          apellidos == other.apellidos;

  @override
  int get hashCode => id.hashCode ^ nombres.hashCode ^ apellidos.hashCode;
}
