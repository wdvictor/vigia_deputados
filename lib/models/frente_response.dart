import 'dart:convert';

FrenteResponse frenteResponseFromJson(String str) => FrenteResponse.fromJson(json.decode(str));

String frenteResponseToJson(FrenteResponse data) => json.encode(data.toJson());

class FrenteResponse {
  Dados dados;
  List<Link> links;

  FrenteResponse({
    required this.dados,
    required this.links,
  });

  factory FrenteResponse.fromJson(Map<String, dynamic> json) => FrenteResponse(
        dados: Dados.fromJson(json["dados"]),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dados": dados.toJson(),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class Dados {
  int id;
  String uri;
  String titulo;
  int idLegislatura;
  String telefone;
  String email;
  dynamic keywords;
  dynamic idSituacao;
  String situacao;
  dynamic urlWebsite;
  String urlDocumento;
  Coordenador coordenador;

  Dados({
    required this.id,
    required this.uri,
    required this.titulo,
    required this.idLegislatura,
    required this.telefone,
    required this.email,
    required this.keywords,
    required this.idSituacao,
    required this.situacao,
    required this.urlWebsite,
    required this.urlDocumento,
    required this.coordenador,
  });

  factory Dados.fromJson(Map<String, dynamic> json) => Dados(
        id: json["id"],
        uri: json["uri"],
        titulo: json["titulo"],
        idLegislatura: json["idLegislatura"],
        telefone: json["telefone"],
        email: json["email"],
        keywords: json["keywords"],
        idSituacao: json["idSituacao"],
        situacao: json["situacao"],
        urlWebsite: json["urlWebsite"],
        urlDocumento: json["urlDocumento"],
        coordenador: Coordenador.fromJson(json["coordenador"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uri": uri,
        "titulo": titulo,
        "idLegislatura": idLegislatura,
        "telefone": telefone,
        "email": email,
        "keywords": keywords,
        "idSituacao": idSituacao,
        "situacao": situacao,
        "urlWebsite": urlWebsite,
        "urlDocumento": urlDocumento,
        "coordenador": coordenador.toJson(),
      };
}

class Coordenador {
  int id;
  String uri;
  String nome;
  String siglaPartido;
  String uriPartido;
  String siglaUf;
  int idLegislatura;
  String urlFoto;
  String email;

  Coordenador({
    required this.id,
    required this.uri,
    required this.nome,
    required this.siglaPartido,
    required this.uriPartido,
    required this.siglaUf,
    required this.idLegislatura,
    required this.urlFoto,
    required this.email,
  });

  factory Coordenador.fromJson(Map<String, dynamic> json) => Coordenador(
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
  String rel;
  String href;

  Link({
    required this.rel,
    required this.href,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel,
        "href": href,
      };
}
