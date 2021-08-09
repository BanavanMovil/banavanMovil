import 'package:banavanmov/providers/jCampoProvider.dart';

import 'package:banavanmov/model/jCampo.dart';
import 'dart:async';

class JCampoRepository {
  JCampoProvider _provider = JCampoProvider();

  Future<List<JefeCampoModel>> fetchAllDailyInfo() async {
    final response = await _provider.getAll();
    return JefeCampoResponse.fromJson(response).results;
  }
}
