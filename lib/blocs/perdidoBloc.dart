import 'dart:async';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/repositories/perdidoRepository.dart';
import 'package:banavanmov/model/perdido.dart';

class PerdidoBloc {
  PerdidoRepository perdidoRepository;
  StreamController perdidoListController;

  StreamSink<Response<List<Perdido>>> get movieListSink =>
      perdidoListController.sink;
  Stream<Response<List<Perdido>>> get movieListStream =>
      perdidoListController.stream;
  PerdidoBloc() {
    perdidoListController = StreamController<Response<List<Perdido>>>();
    perdidoRepository = PerdidoRepository();
    fetchAllPerdidos();
  }

  fetchAllPerdidos() async {
    movieListSink.add(Response.loading('Fetching Data of Perdidos'));
    try {
      List<Perdido> perdidos = await perdidoRepository.fetchAllPerdidos();
      movieListSink.add(Response.completed(perdidos));
    } catch (e) {
      movieListSink.add(Response.error(e.toString()));
      //print(e);
    }
  }

  dispose() {
    perdidoListController?.close();
  }
}
