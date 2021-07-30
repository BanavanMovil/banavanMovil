import 'dart:async';
import 'package:banavanmov/model/actividad.dart';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/repositories/actividadRepository.dart';
import 'package:banavanmov/model/cosechado.dart';

class ActividadBloc {
  ActividadRepository actividadRepository;
  StreamController actividadListController;

  StreamSink<Response<List<Actividad>>> get actividadListSink =>
      actividadListController.sink;
  Stream<Response<List<Actividad>>> get actividadListStream =>
      actividadListController.stream;

  ActividadBloc() {
    actividadListController = StreamController<Response<List<Actividad>>>();
    actividadRepository = ActividadRepository();
    fetchAllActividades();
  }

  fetchAllActividades() async {
    actividadListSink.add(Response.loading('Cargando datos de Actividades'));
    try {
      List<Actividad> actividades =
          await actividadRepository.fetchAllActividades();
      actividadListSink.add(Response.completed(actividades));
    } catch (e) {
      actividadListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    actividadListController?.close();
  }
}
