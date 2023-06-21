import 'package:http/http.dart';
import 'package:vigia_deputados/backend/repositories/partidos_repositories.dart';
import 'package:vigia_deputados/models/partidos_response.dart';

class APIpartidos implements PartidoRepository {
  @override
  Future<PartidosResponse> getPartidos(
      {int pagina = 1, String sortBy = 'sigla'}) async {
    try {
      Response response = await get(Uri.parse(
          'https://dadosabertos.camara.leg.br/api/v2/partidos?pagina=$pagina&ordenarPor=$sortBy'));
      return partidosResponseFromJson(response.body);
    } catch (exception) {
      rethrow;
    }
  }
}
