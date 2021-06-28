import 'dart:async';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/repositories/jCampoRepository.dart';
import 'package:banavanmov/model/jCampo.dart';

class JCampoBloc {
  JCampoRepository jCampoRepository;
  StreamController jCListController;

  StreamSink<Response<List<JefeCampoModel>>> get jcListSink =>
      jCListController.sink;
  Stream<Response<List<JefeCampoModel>>> get jcListStream =>
      jCListController.stream;
  JCampoBloc() {
    jCListController = StreamController<Response<List<JefeCampoModel>>>();
    jCampoRepository = JCampoRepository();
    fetchAllDailyInfo();
  }

  fetchAllDailyInfo() async {
    jcListSink.add(Response.loading('Fetching Data of Workers'));
    try {
      List<JefeCampoModel> movies = await jCampoRepository.fetchAllDailyInfo();
      jcListSink.add(Response.completed(movies));
    } catch (e) {
      jcListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    jCListController?.close();
  }
}
