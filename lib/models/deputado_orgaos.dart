// To parse this JSON data, do
//
//     final orgaosResponse = orgaosResponseFromJson(jsonString);

import 'dart:convert';

OrgaosResponse orgaosResponseFromJson(String str) => OrgaosResponse.fromJson(json.decode(str));

String orgaosResponseToJson(OrgaosResponse data) => json.encode(data.toJson());

class OrgaosResponse {
  List<OrgaosDado> dados;
  List<Link> links;

  OrgaosResponse({
    required this.dados,
    required this.links,
  });

  factory OrgaosResponse.fromJson(Map<String, dynamic> json) => OrgaosResponse(
        dados: List<OrgaosDado>.from(json["dados"].map((x) => OrgaosDado.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dados": List<dynamic>.from(dados.map((x) => x.toJson())),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class OrgaosDado {
  int idOrgao;
  String uriOrgao;
  String siglaOrgao;
  String nomeOrgao;
  String nomePublicacao;
  String titulo;
  String codTitulo;
  DateTime dataInicio;
  DateTime? dataFim;

  OrgaosDado({
    required this.idOrgao,
    required this.uriOrgao,
    required this.siglaOrgao,
    required this.nomeOrgao,
    required this.nomePublicacao,
    required this.titulo,
    required this.codTitulo,
    required this.dataInicio,
    required this.dataFim,
  });

  factory OrgaosDado.fromJson(Map<String, dynamic> json) {
    try {
      return OrgaosDado(
        idOrgao: json["idOrgao"],
        uriOrgao: json["uriOrgao"],
        siglaOrgao: json["siglaOrgao"],
        nomeOrgao: json["nomeOrgao"],
        nomePublicacao: json["nomePublicacao"],
        titulo: json["titulo"],
        codTitulo: json["codTitulo"],
        dataInicio: DateTime.parse(json['dataInicio']),
        dataFim: DateTime.tryParse(json["dataFim"] ?? ''),
      );
    } catch (exception) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "idOrgao": idOrgao,
        "uriOrgao": uriOrgao,
        "siglaOrgao": siglaOrgao,
        "nomeOrgao": nomeOrgao,
        "nomePublicacao": nomePublicacao,
        "titulo": titulo,
        "codTitulo": codTitulo,
        "dataInicio": dataInicio,
        "dataFim": dataFim,
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
