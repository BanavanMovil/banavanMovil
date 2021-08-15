import 'package:banavanmov/model/actividad.dart';
import 'package:banavanmov/model/color.dart';
import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/model/semana.dart';
import 'package:banavanmov/model/solicitudTipo.dart';
import 'package:flutter/material.dart';

import 'package:banavanmov/providers/colorProvider.dart';

class DataSource {
  crearDataSourceColor(List<Colour> colores) {
    var lista = [];

    colores.forEach((element) {
      var pedazo = {
        "display": element.hex_code.toString(),
        "value": element.nombre.toString()
      };
      lista.add(pedazo);
    });
    return lista;
  }

  crearDataSourcePersonnel(List<Personnel> personal) {
    var lista = [];

    personal.forEach((element) {
      var pedazo = {
        "display":
            element.nombres.toString() + ' ' + element.apellidos.toString(),
        "value": element.id.toString()
      };
      if (element.activo.toString() == '1' &&
          element.rol.toString() == 'Trabajador') {
        lista.add(pedazo);
      }
    });
    return lista;
  }

  crearDataSourceSemana(List<Semana> semanas) {
    var lista = [];

    semanas.forEach((element) {
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.numero.toString()
      };

      lista.add(pedazo);
    });
    return lista;
  }

  crearDataSourceLote(List<Lote> lotes) {
    var lista = [];

    lotes.forEach((element) {
      var pedazo = {
        "display": element.numero.toString(),
        "value": element.numero.toString()
      };

      lista.add(pedazo);
    });
    return lista;
  }

  crearDataSourceSolicitudTipo(List<SolicitudTipo> tipos) {
    var lista = [];

    //print(lista2);
    tipos.forEach((element) {
      //print(element.id.toString() + element.titulo.toString());
      var pedazo = {
        "display": element.titulo.toString(),
        "value": element.id.toString()
      };
      lista.add(pedazo);
    });
    //print(lista);
    return lista;
  }

  crearDataSourceActividad(List<Actividad> actividades) {
    var lista = [];

    //print(lista2);
    actividades.forEach((element) {
      //print(element.id.toString() + element.nombre.toString());
      var pedazo = {
        "display": element.nombre.toString(),
        "value": element.id.toString()
      };
      lista.add(pedazo);
    });
    //print(lista);
    return lista;
  }

  Color getColorFromHex(String hexColor) {
    if (hexColor != null) {
      hexColor = hexColor.replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      if (hexColor.length == 8) {
        return Color(int.parse("0x$hexColor"));
      }
    }
  }
}
