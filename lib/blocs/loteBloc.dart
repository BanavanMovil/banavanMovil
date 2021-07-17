import 'dart:async';
import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/repositories/loteRepository.dart';

class LoteBloc {
  LoteRepository loteRepository;
  StreamController loteListController;

  StreamSink<Response<List<Lote>>> get loteListSink => loteListController.sink;
  Stream<Response<List<Lote>>> get loteListStream => loteListController.stream;
  CosechadoBloc() {
    loteListController = StreamController<Response<List<Lote>>>();
    loteRepository = LoteRepository();
    fetchAllCosechados();
  }

  fetchAllCosechados() async {
    loteListSink.add(Response.loading('Fetching Data of Lote'));
    try {
      List<Lote> cosechados = await loteRepository.fetchAllLotes();
      loteListSink.add(Response.completed(cosechados));
    } catch (e) {
      loteListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    loteListController?.close();
  }
}
