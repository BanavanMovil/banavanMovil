import 'package:http/http.dart' as http;
import 'dart:convert';

class JCampoProvider {
  final String url = "https://api.jsonbin.io/b/60aaf347b2b1d74df21bab8c";

  Future<List<dynamic>> getInfo() async {
    final resp = await http.get(url);

    final List<dynamic> decodedData = json.decode(resp.body);
    print(decodedData);
    return decodedData;
  }
}
