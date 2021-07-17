import 'package:banavanmov/model/lote.dart';
import 'package:banavanmov/providers/loteProvider.dart';

class LoteRepository {
  LoteProvider _provider = LoteProvider();

  Future<List<Lote>> fetchAllLotes() async {
    final response = await _provider.getAll();
    return LoteResponse.fromJson(response).results;
  }
}
