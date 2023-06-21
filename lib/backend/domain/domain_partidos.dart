import 'package:vigia_deputados/backend/repositories/partidos_repositories.dart';
import 'package:vigia_deputados/models/partidos_response.dart';

class PartidoDomain {
  final PartidoRepository _partidoRepository;

  PartidoDomain(this._partidoRepository);

  Future<PartidosResponse> getPartidos(
      {int pagina = 1, String sortBy = 'sigla'}) async {
    return _partidoRepository.getPartidos(pagina: pagina, sortBy: sortBy);
  }
}
