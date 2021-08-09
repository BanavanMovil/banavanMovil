import 'dart:async';
import 'package:banavanmov/model/actividad.dart';
import 'package:banavanmov/model/solicitud.dart';
import 'package:banavanmov/repositories/solicitudRepository.dart';
import 'package:banavanmov/response.dart';

class SolicitudBloc {
  SolicitudRepository solicitudRepository;
  StreamController solicitudListController;

  StreamSink<Response<List<Solicitud>>> get solicitudListSink =>
      solicitudListController.sink;
  Stream<Response<List<Solicitud>>> get solicitudListStream =>
      solicitudListController.stream;

  SolicitudBloc() {
    solicitudListController = StreamController<Response<List<Solicitud>>>();
    solicitudRepository = SolicitudRepository();
    fetchAllSolicitudes();
  }

  fetchAllSolicitudes() async {
    solicitudListSink.add(Response.loading('Cargando datos de Actividades'));
    try {
      List<Solicitud> solicitudes =
          await solicitudRepository.fetchAllSolicitudes();
      solicitudListSink.add(Response.completed(solicitudes));
    } catch (e) {
      solicitudListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    solicitudListController?.close();
  }
}
