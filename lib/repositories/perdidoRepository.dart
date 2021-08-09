import 'package:banavanmov/providers/perdidoProvider.dart';

import 'package:banavanmov/model/perdido.dart';
import 'dart:async';

class PerdidoRepository {
  PerdidoProvider _provider = PerdidoProvider();

  Future<List<Perdido>> fetchAllPerdidos() async {
    final response = await _provider.getAll();
    return PerdidoResponse.fromJson(response).results;
  }
}
