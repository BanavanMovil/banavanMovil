import 'dart:async';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/repositories/cosechadoRepository.dart';
import 'package:banavanmov/model/cosechado.dart';

class CosechadoBloc {
  CosechadoRepository cosechadoRepository;
  StreamController cosechadoListController;

  StreamSink<Response<List<Cosechado>>> get movieListSink =>
      cosechadoListController.sink;
  Stream<Response<List<Cosechado>>> get movieListStream =>
      cosechadoListController.stream;
  CosechadoBloc() {
    cosechadoListController = StreamController<Response<List<Cosechado>>>();
    cosechadoRepository = CosechadoRepository();
    fetchAllCosechados();
  }

  fetchAllCosechados() async {
    movieListSink.add(Response.loading('Fetching Data of Cosechados'));
    try {
      List<Cosechado> cosechados =
          await cosechadoRepository.fetchAllCosechados();
      movieListSink.add(Response.completed(cosechados));
    } catch (e) {
      movieListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    cosechadoListController?.close();
  }
}
