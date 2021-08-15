import 'package:banavanmov/model/personnel.dart';
import 'dart:async';
import 'package:banavanmov/providers/personnelProvider.dart';

class PersonnelRepository {
  PersonnelProvider _provider = PersonnelProvider();

  Future<List<Personnel>> fetchAllpersonnel() async {
    final response = await _provider.getAll();
    //print(response);
    return response;
  }
}
