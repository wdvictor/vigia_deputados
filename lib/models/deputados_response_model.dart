import 'dart:convert';

DeputadosResponse deputadosResponseFromJson(String str) =>
    DeputadosResponse.fromJson(json.decode(str));

String deputadosResponseToJson(DeputadosResponse data) => json.encode(data.toJson());

class DeputadosResponse {
  DeputadosResponse({
    required this.dados,
    required this.links,
  });

  List<DeputadoDado> dados;
  List<Link> links;

  factory DeputadosResponse.fromJson(Map<String, dynamic> json) => DeputadosResponse(
        dados: List<DeputadoDado>.from(json["dados"].map((x) => DeputadoDado.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dados": List<dynamic>.from(dados.map((x) => x.toJson())),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class DeputadoDado {
  DeputadoDado({
    required this.id,
    required this.uri,
    required this.nome,
    required this.siglaPartido,
    required this.uriPartido,
    required this.siglaUf,
    required this.idLegislatura,
    required this.urlFoto,
    this.email,
  });

  int id;
  String uri;
  String nome;
  String siglaPartido;
  String uriPartido;
  String siglaUf;
  int idLegislatura;
  String urlFoto;
  String? email;

  factory DeputadoDado.fromJson(Map<String, dynamic> json) {
    try {
      return DeputadoDado(
        id: json["id"],
        uri: json["uri"],
        nome: json["nome"],
        siglaPartido: json["siglaPartido"],
        uriPartido: json["uriPartido"],
        siglaUf: json["siglaUf"],
        idLegislatura: json["idLegislatura"],
        urlFoto: json["urlFoto"],
        email: json["email"],
      );
    } catch (exception) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "uri": uri,
        "nome": nome,
        "siglaPartido": siglaPartido,
        "uriPartido": uriPartido,
        "siglaUf": siglaUf,
        "idLegislatura": idLegislatura,
        "urlFoto": urlFoto,
        "email": email,
      };
}

class Link {
  Link({
    this.rel,
    this.href,
  });

  String? rel;
  String? href;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel,
        "href": href,
      };
}
