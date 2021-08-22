import 'package:banavanmov/model/actividad.dart';
import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/model/motivo.dart';

class Util {
  obtenerLoteDeId(int id, List<Lote> lotes) {
    if (lotes != null) {
      var lote = lotes.firstWhere((element) => element.id == id);
      return lote.numero;
    }
    return null;
  }

  obtenerMotivoDeId(int id, List<Motivo> motivos) {
    if (motivos != null) {
      var motivo = motivos.firstWhere((element) => element.id == id);
      return motivo.titulo;
    }
    return null;
  }

  obtenerTrabajadorDeId(int id, List<Personnel> personal) {
    if (personal != null) {
      var t = personal.firstWhere((element) => element.id == id);
      return t.nombres + " " + t.apellidos;
    }
    return null;
  }

  obtenerSemanaDeId(int id, List<Semana> semanas) {
    //print(semanas);
    if (semanas != null) {
      var t = semanas.firstWhere((element) => element.id == id);
      //print("Aqui esta la semana");
      return t;
    }
    return null;
  }

  obtenerColorDeId(int id, List<Colour> colores) {
    if (colores != null) {
      var t = colores.firstWhere((element) => element.id == id);
      return t.hex_code;
    }
    return null;
  }

  obtenerActividadDeId(int id, List<Actividad> actividades) {
    if (actividades != null) {
      var t = actividades.firstWhere((element) => element.id == id);
      return t.nombre;
    }
    return null;
  }

  obtenerColorNDeId(int id, List<Colour> colores) {
    var t = colores.firstWhere((element) => element.id == id);
    return t.nombre;
  }
}
