class NewObjectTwo {
  int id;
  int lote_id;
  int cantidad;
  int user_id;
  String fecha;
  int color_id;

  NewObjectTwo({
    this.id,
    this.lote_id,
    this.cantidad,
    this.user_id,
    this.color_id,
    this.fecha,
  });

  factory NewObjectTwo.fromJson(Map<String, dynamic> json) => NewObjectTwo(
        id: json['id'],
        lote_id: json['lote_id'],
        cantidad: json['cantidad'],
        user_id: json['user_id'],
        color_id: json['color_id'],
        fecha: json['fecha'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'lote_id': lote_id,
        'cantidad': cantidad,
        'user_id': user_id,
        'color_id': color_id,
        'fecha': fecha,
      };
}
