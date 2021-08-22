class NewObject {
  //int id;
  int lote_id;
  int cantidad;
  int user_id;
  String fecha;
  int color_id;
  int perdida_motivo_id;

  NewObject({
    //this.id,
    this.lote_id,
    this.cantidad,
    this.user_id,
    this.color_id,
    this.fecha,
    this.perdida_motivo_id,
  });

  factory NewObject.fromJson(Map<String, dynamic> json) => NewObject(
        //id: json['id'],
        lote_id: json['lote_id'],
        cantidad: json['cantidad'],
        user_id: json['user_id'],
        color_id: json['color_id'],
        fecha: json['fecha'],
        perdida_motivo_id: json['perdida_motivo_id'],
      );

  Map<String, dynamic> toJson() => {
        //'id': id,
        'lote_id': lote_id,
        'cantidad': cantidad,
        'user_id': user_id,
        'color_id': color_id,
        'fecha': fecha,
        'perdida_motivo_id': perdida_motivo_id,
      };
}
