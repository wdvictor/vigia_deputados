import 'dart:convert';

DeputadoDetalhadoResponse deputadoDetalhadoResponseFromJson(String str) =>
    DeputadoDetalhadoResponse.fromJson(json.decode(str));

String deputadoDetalhadoResponseToJson(DeputadoDetalhadoResponse data) =>
    json.encode(data.toJson());

class DeputadoDetalhadoResponse {
  DeputadoDetalhadoResponse({
    required this.dados,
    required this.links,
  });

  DeputadoDetalhadoDado dados;
  List<Link> links;

  factory DeputadoDetalhadoResponse.fromJson(Map<String, dynamic> json) =>
      DeputadoDetalhadoResponse(
        dados: DeputadoDetalhadoDado.fromJson(json["dados"]),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dados": dados.toJson(),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class DeputadoDetalhadoDado {
  DeputadoDetalhadoDado({
    required this.id,
    required this.uri,
    required this.nomeCivil,
    required this.ultimoStatus,
    required this.cpf,
    required this.sexo,
    this.urlWebsite,
    required this.redeSocial,
    required this.dataNascimento,
    this.dataFalecimento,
    required this.ufNascimento,
    required this.municipioNascimento,
    required this.escolaridade,
  });

  int id;
  String uri;
  String nomeCivil;
  UltimoStatus ultimoStatus;
  String cpf;
  String sexo;
  dynamic urlWebsite;
  List<dynamic> redeSocial;
  DateTime dataNascimento;
  dynamic dataFalecimento;
  String ufNascimento;
  String municipioNascimento;
  String escolaridade;

  factory DeputadoDetalhadoDado.fromJson(Map<String, dynamic> json) => DeputadoDetalhadoDado(
        id: json["id"],
        uri: json["uri"],
        nomeCivil: json["nomeCivil"],
        ultimoStatus: UltimoStatus.fromJson(json["ultimoStatus"]),
        cpf: json["cpf"],
        sexo: json["sexo"],
        urlWebsite: json["urlWebsite"],
        redeSocial: List<dynamic>.from(json["redeSocial"].map((x) => x)),
        dataNascimento: DateTime.parse(json["dataNascimento"]),
        dataFalecimento: json["dataFalecimento"],
        ufNascimento: json["ufNascimento"],
        municipioNascimento: json["municipioNascimento"],
        escolaridade: json["escolaridade"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uri": uri,
        "nomeCivil": nomeCivil,
        "ultimoStatus": ultimoStatus.toJson(),
        "cpf": cpf,
        "sexo": sexo,
        "urlWebsite": urlWebsite,
        "redeSocial": List<dynamic>.from(redeSocial.map((x) => x)),
        "dataNascimento":
            "${dataNascimento.year.toString().padLeft(4, '0')}-${dataNascimento.month.toString().padLeft(2, '0')}-${dataNascimento.day.toString().padLeft(2, '0')}",
        "dataFalecimento": dataFalecimento,
        "ufNascimento": ufNascimento,
        "municipioNascimento": municipioNascimento,
        "escolaridade": escolaridade,
      };
}

class UltimoStatus {
  UltimoStatus({
    required this.id,
    required this.uri,
    required this.nome,
    required this.siglaPartido,
    required this.uriPartido,
    required this.siglaUf,
    required this.idLegislatura,
    required this.urlFoto,
    required this.email,
    required this.data,
    required this.nomeEleitoral,
    required this.gabinete,
    required this.situacao,
    required this.condicaoEleitoral,
    required this.descricaoStatus,
  });

  int id;
  String uri;
  String nome;
  String siglaPartido;
  String uriPartido;
  String siglaUf;
  int idLegislatura;
  String urlFoto;
  String email;
  String data;
  String nomeEleitoral;
  Gabinete gabinete;
  String situacao;
  String condicaoEleitoral;
  dynamic descricaoStatus;

  factory UltimoStatus.fromJson(Map<String, dynamic> json) => UltimoStatus(
        id: json["id"],
        uri: json["uri"],
        nome: json["nome"],
        siglaPartido: json["siglaPartido"],
        uriPartido: json["uriPartido"],
        siglaUf: json["siglaUf"],
        idLegislatura: json["idLegislatura"],
        urlFoto: json["urlFoto"],
        email: json["email"],
        data: json["data"],
        nomeEleitoral: json["nomeEleitoral"],
        gabinete: Gabinete.fromJson(json["gabinete"]),
        situacao: json["situacao"],
        condicaoEleitoral: json["condicaoEleitoral"],
        descricaoStatus: json["descricaoStatus"],
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
        "data": data,
        "nomeEleitoral": nomeEleitoral,
        "gabinete": gabinete.toJson(),
        "situacao": situacao,
        "condicaoEleitoral": condicaoEleitoral,
        "descricaoStatus": descricaoStatus,
      };
}

class Gabinete {
  Gabinete({
    this.nome,
    this.predio,
    this.sala,
    this.andar,
    this.telefone,
    this.email,
  });

  String? nome;
  String? predio;
  String? sala;
  String? andar;
  String? telefone;
  String? email;

  factory Gabinete.fromJson(Map<String, dynamic> json) => Gabinete(
        nome: json["nome"],
        predio: json["predio"],
        sala: json["sala"],
        andar: json["andar"],
        telefone: json["telefone"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "nome": nome,
        "predio": predio,
        "sala": sala,
        "andar": andar,
        "telefone": telefone,
        "email": email,
      };
}

class Link {
  Link({
    required this.rel,
    required this.href,
  });

  String rel;
  String href;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel,
        "href": href,
      };
}
