import 'dart:async';
import 'package:banavanmov/model/personnel.dart';
import 'package:banavanmov/repositories/personnelRepository.dart';
import 'package:banavanmov/response.dart';

class PersonnelBloc {
  PersonnelRepository personnelRepository;
  StreamController personnelListController;

  StreamSink<Response<List<Personnel>>> get personnelListSink =>
      personnelListController.sink;
  Stream<Response<List<Personnel>>> get personnelListStream =>
      personnelListController.stream;
  PersonnelBloc() {
    personnelListController = StreamController<Response<List<Personnel>>>();
    personnelRepository = PersonnelRepository();
    fetchAllPersonnel();
  }

  fetchAllPersonnel() async {
    personnelListSink.add(Response.loading('Fetching Data of Workers'));
    try {
      List<Personnel> personnel = await personnelRepository.fetchAllpersonnel();
      personnelListSink.add(Response.completed(personnel));
    } catch (e) {
      personnelListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    personnelListController?.close();
  }
}
