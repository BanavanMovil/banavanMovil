import 'package:banavanmov/providers/cosechadoProvider.dart';

import 'package:banavanmov/model/cosechado.dart';
import 'dart:async';

class CosechadoRepository {
  CosechadoProvider _provider = CosechadoProvider();

  Future<List<Cosechado>> fetchAllCosechados() async {
    final response = await _provider.getAll();
    return CosechadoResponse.fromJson(response).results;
  }
}
