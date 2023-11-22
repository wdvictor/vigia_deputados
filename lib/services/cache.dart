import 'package:shared_preferences/shared_preferences.dart';
import 'package:vigia_deputados/models/deputados_response_model.dart';

class Cache {
  Future<void> favorite(DeputadoDado deputadoDado, bool? favorite) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (favorite == null) {
      prefs.setString(deputadoDado.id.toString(), deputadoDado.toJson().toString());
      return;
    }
    if (!favorite) {
      prefs.setString(deputadoDado.id.toString(), deputadoDado.toJson().toString());
    } else {
      prefs.remove(deputadoDado.id.toString());
    }
  }

  Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    Set<String> ids = prefs.getKeys();

    if (ids.isNotEmpty) {
      return prefs.getKeys();
    }
    return {};
  }
}
