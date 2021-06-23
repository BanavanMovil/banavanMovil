import 'dart:async';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/repositories/enfundadoRepository.dart';
import 'package:banavanmov/model/enfundado.dart';
import 'package:sentry/sentry.dart';

class EnfundadoBloc {
  EnfundadoRepository enfundadoRepository;
  StreamController enfundadoListController;

  StreamSink<Response<List<Enfundado>>> get movieListSink =>
      enfundadoListController.sink;
  Stream<Response<List<Enfundado>>> get movieListStream =>
      enfundadoListController.stream;
  EnfundadoBloc() {
    enfundadoListController = StreamController<Response<List<Enfundado>>>();
    enfundadoRepository = EnfundadoRepository();
    fetchAllEnfundados();
  }

  fetchAllEnfundados() async {
    movieListSink.add(Response.loading('Fetching Data of Enfundados'));
    try {
      List<Enfundado> enfundados =
          await enfundadoRepository.fetchAllEnfundados();
      movieListSink.add(Response.completed(enfundados));
    } catch (e, stackTrace) {
      await Sentry.captureException(
        e,
        stackTrace: stackTrace,
      );
      movieListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    enfundadoListController?.close();
  }
}
