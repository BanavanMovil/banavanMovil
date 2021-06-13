import 'package:banavanmov/providers/enfundadoProvider.dart';
import 'package:banavanmov/response.dart';
import 'package:banavanmov/model/enfundado.dart';
import 'dart:async';

class EnfundadoRepository {
  EnfundadoProvider _provider = EnfundadoProvider();

  Future<List<Enfundado>> fetchAllEnfundados() async {
    final response = await _provider.getAll();
    return EnfundadoResponse.fromJson(response).results;
  }
}
