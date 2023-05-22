// To parse this JSON data, do
//
//     final partidosResponse = partidosResponseFromJson(jsonString);

import 'dart:convert';

PartidosResponse partidosResponseFromJson(String str) =>
    PartidosResponse.fromJson(json.decode(str));

String partidosResponseToJson(PartidosResponse data) =>
    json.encode(data.toJson());

class PartidosResponse {
  List<Dado> dados;
  List<Link> links;

  PartidosResponse({
    required this.dados,
    required this.links,
  });

  factory PartidosResponse.fromJson(Map<String, dynamic> json) =>
      PartidosResponse(
        dados: List<Dado>.from(json["dados"].map((x) => Dado.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dados": List<dynamic>.from(dados.map((x) => x.toJson())),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class Dado {
  int id;
  String sigla;
  String nome;
  String uri;

  Dado({
    required this.id,
    required this.sigla,
    required this.nome,
    required this.uri,
  });

  factory Dado.fromJson(Map<String, dynamic> json) => Dado(
        id: json["id"],
        sigla: json["sigla"],
        nome: json["nome"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sigla": sigla,
        "nome": nome,
        "uri": uri,
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
