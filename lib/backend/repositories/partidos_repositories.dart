import 'package:vigia_deputados/models/partidos_response.dart';

abstract class PartidoRepository {
  Future<PartidosResponse> getPartidos({int pagina, String sortBy});
}
