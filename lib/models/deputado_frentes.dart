// To parse this JSON data, do
//
//     final frentesResponse = frentesResponseFromJson(jsonString);

import 'dart:convert';

FrentesResponse frentesResponseFromJson(String str) => FrentesResponse.fromJson(json.decode(str));

String frentesResponseToJson(FrentesResponse data) => json.encode(data.toJson());

class FrentesResponse {
  List<FrentesDado> dados;
  List<Link> links;

  FrentesResponse({
    required this.dados,
    required this.links,
  });

  factory FrentesResponse.fromJson(Map<String, dynamic> json) => FrentesResponse(
        dados: List<FrentesDado>.from(json["dados"].map((x) => FrentesDado.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dados": List<dynamic>.from(dados.map((x) => x.toJson())),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class FrentesDado {
  int id;
  String uri;
  String titulo;
  int idLegislatura;

  FrentesDado({
    required this.id,
    required this.uri,
    required this.titulo,
    required this.idLegislatura,
  });

  factory FrentesDado.fromJson(Map<String, dynamic> json) => FrentesDado(
        id: json["id"],
        uri: json["uri"],
        titulo: json["titulo"],
        idLegislatura: json["idLegislatura"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uri": uri,
        "titulo": titulo,
        "idLegislatura": idLegislatura,
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
