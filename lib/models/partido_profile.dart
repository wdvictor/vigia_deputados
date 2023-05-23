// To parse this JSON data, do
//
//     final partidoProfile = partidoProfileFromJson(jsonString);

import 'dart:convert';

PartidoProfile partidoProfileFromJson(String str) =>
    PartidoProfile.fromJson(json.decode(str));

String partidoProfileToJson(PartidoProfile data) => json.encode(data.toJson());

class PartidoProfile {
  Dados dados;
  List<Link> links;

  PartidoProfile({
    required this.dados,
    required this.links,
  });

  factory PartidoProfile.fromJson(Map<String, dynamic> json) => PartidoProfile(
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
  String sigla;
  String nome;
  String uri;
  Status status;
  dynamic numeroEleitoral;
  String urlLogo;
  dynamic urlWebSite;
  dynamic urlFacebook;

  Dados({
    required this.id,
    required this.sigla,
    required this.nome,
    required this.uri,
    required this.status,
    this.numeroEleitoral,
    required this.urlLogo,
    this.urlWebSite,
    this.urlFacebook,
  });

  factory Dados.fromJson(Map<String, dynamic> json) => Dados(
        id: json["id"],
        sigla: json["sigla"],
        nome: json["nome"],
        uri: json["uri"],
        status: Status.fromJson(json["status"]),
        numeroEleitoral: json["numeroEleitoral"],
        urlLogo: json["urlLogo"],
        urlWebSite: json["urlWebSite"],
        urlFacebook: json["urlFacebook"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sigla": sigla,
        "nome": nome,
        "uri": uri,
        "status": status.toJson(),
        "numeroEleitoral": numeroEleitoral,
        "urlLogo": urlLogo,
        "urlWebSite": urlWebSite,
        "urlFacebook": urlFacebook,
      };
}

class Status {
  String data;
  String idLegislatura;
  String situacao;
  String totalPosse;
  String totalMembros;
  String uriMembros;
  Lider lider;

  Status({
    required this.data,
    required this.idLegislatura,
    required this.situacao,
    required this.totalPosse,
    required this.totalMembros,
    required this.uriMembros,
    required this.lider,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        data: json["data"],
        idLegislatura: json["idLegislatura"],
        situacao: json["situacao"],
        totalPosse: json["totalPosse"],
        totalMembros: json["totalMembros"],
        uriMembros: json["uriMembros"],
        lider: Lider.fromJson(json["lider"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "idLegislatura": idLegislatura,
        "situacao": situacao,
        "totalPosse": totalPosse,
        "totalMembros": totalMembros,
        "uriMembros": uriMembros,
        "lider": lider.toJson(),
      };
}

class Lider {
  String uri;
  String nome;
  String siglaPartido;
  String uriPartido;
  String uf;
  int idLegislatura;
  String urlFoto;

  Lider({
    required this.uri,
    required this.nome,
    required this.siglaPartido,
    required this.uriPartido,
    required this.uf,
    required this.idLegislatura,
    required this.urlFoto,
  });

  factory Lider.fromJson(Map<String, dynamic> json) => Lider(
        uri: json["uri"],
        nome: json["nome"],
        siglaPartido: json["siglaPartido"],
        uriPartido: json["uriPartido"],
        uf: json["uf"],
        idLegislatura: json["idLegislatura"],
        urlFoto: json["urlFoto"],
      );

  Map<String, dynamic> toJson() => {
        "uri": uri,
        "nome": nome,
        "siglaPartido": siglaPartido,
        "uriPartido": uriPartido,
        "uf": uf,
        "idLegislatura": idLegislatura,
        "urlFoto": urlFoto,
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
