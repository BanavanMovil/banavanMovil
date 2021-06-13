import 'dart:async';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/repositories/jCampoRepository.dart';
import 'package:banavanmov/model/jCampo.dart';

class JCampoBloc {
  JCampoRepository jCampoRepository;
  StreamController jCListController;

  StreamSink<Response<List<JefeCampoModel>>> get movieListSink =>
      jCListController.sink;
  Stream<Response<List<JefeCampoModel>>> get movieListStream =>
      jCListController.stream;
  JCampoBloc() {
    jCListController = StreamController<Response<List<JefeCampoModel>>>();
    jCampoRepository = JCampoRepository();
    fetchAllDailyInfo();
  }

  fetchAllDailyInfo() async {
    movieListSink.add(Response.loading('Fetching Data of Workers'));
    try {
      List<JefeCampoModel> movies = await jCampoRepository.fetchAllDailyInfo();
      movieListSink.add(Response.completed(movies));
    } catch (e) {
      movieListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    jCListController?.close();
  }
}
