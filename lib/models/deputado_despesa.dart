// ignore_for_file: constant_identifier_names
//cSpell:ignore cnpj ESCRITRIO COMBUSTVEIS DIVULGAO SERVIOS ELETRNICA
import 'dart:convert';

import 'dart:developer';

DeputadoDespesas deputadoDespesasFromJson(String str) =>
    DeputadoDespesas.fromJson(json.decode(str));

String deputadoDespesasToJson(DeputadoDespesas data) =>
    json.encode(data.toJson());

class DeputadoDespesas {
  DeputadoDespesas({
    required this.dados,
    required this.links,
  });

  List<DeputadoDespesasDado> dados;
  List<Link> links;

  factory DeputadoDespesas.fromJson(Map<String, dynamic> json) =>
      DeputadoDespesas(
        dados: List<DeputadoDespesasDado>.from(
            json["dados"].map((x) => DeputadoDespesasDado.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dados": List<dynamic>.from(dados.map((x) => x.toJson())),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class DeputadoDespesasDado {
  DeputadoDespesasDado({
    required this.ano,
    required this.mes,
    required this.tipoDespesa,
    required this.codDocumento,
    required this.tipoDocumento,
    required this.codTipoDocumento,
    required this.dataDocumento,
    required this.numDocumento,
    required this.valorDocumento,
    required this.urlDocumento,
    required this.nomeFornecedor,
    required this.cnpjCpfFornecedor,
    required this.valorLiquido,
    required this.valorGlosa,
    required this.numRessarcimento,
    required this.codLote,
    required this.parcela,
  });

  int ano;
  int mes;
  TipoDespesa? tipoDespesa;
  int codDocumento;
  TipoDocumento? tipoDocumento;
  int codTipoDocumento;
  DateTime dataDocumento;
  String numDocumento;
  double valorDocumento;
  String? urlDocumento;
  String nomeFornecedor;
  String cnpjCpfFornecedor;
  double valorLiquido;
  double valorGlosa;
  String numRessarcimento;
  int codLote;
  int parcela;

  factory DeputadoDespesasDado.fromJson(Map<String, dynamic> json) {
    try {
      return DeputadoDespesasDado(
        ano: json["ano"],
        mes: json["mes"],
        tipoDespesa: tipoDespesaValues.map[json["tipoDespesa"]],
        codDocumento: json["codDocumento"],
        tipoDocumento: tipoDocumentoValues.map[json["tipoDocumento"]],
        codTipoDocumento: json["codTipoDocumento"],
        dataDocumento: DateTime.parse(json["dataDocumento"]),
        numDocumento: json["numDocumento"],
        valorDocumento: json["valorDocumento"].toDouble(),
        urlDocumento: json["urlDocumento"],
        nomeFornecedor: json["nomeFornecedor"],
        cnpjCpfFornecedor: json["cnpjCpfFornecedor"],
        valorLiquido: json["valorLiquido"].toDouble(),
        valorGlosa: json["valorGlosa"].toDouble(),
        numRessarcimento: json["numRessarcimento"],
        codLote: json["codLote"],
        parcela: json["parcela"],
      );
    } catch (exception) {
      log(exception.toString(),
          name: 'DeputadoDespesasDado.fromJson in Deputado despesas');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "ano": ano,
        "mes": mes,
        "tipoDespesa": tipoDespesaValues.reverse?[tipoDespesa],
        "codDocumento": codDocumento,
        "tipoDocumento": tipoDocumentoValues.reverse?[tipoDocumento],
        "codTipoDocumento": codTipoDocumento,
        "dataDocumento":
            "${dataDocumento.year.toString().padLeft(4, '0')}-${dataDocumento.month.toString().padLeft(2, '0')}-${dataDocumento.day.toString().padLeft(2, '0')}",
        "numDocumento": numDocumento,
        "valorDocumento": valorDocumento,
        "urlDocumento": urlDocumento,
        "nomeFornecedor": nomeFornecedor,
        "cnpjCpfFornecedor": cnpjCpfFornecedor,
        "valorLiquido": valorLiquido,
        "valorGlosa": valorGlosa,
        "numRessarcimento": numRessarcimento,
        "codLote": codLote,
        "parcela": parcela,
      };
}

enum TipoDespesa {
  MANUTENO_DE_ESCRITRIO_DE_APOIO_ATIVIDADE_PARLAMENTAR,
  COMBUSTVEIS_E_LUBRIFICANTES,
  DIVULGAO_DA_ATIVIDADE_PARLAMENTAR,
  PASSAGEM_AREA_REEMBOLSO,
  TELEFONIA,
  SERVIOS_POSTAIS
}

final tipoDespesaValues = EnumValues({
  "COMBUST??VEIS E LUBRIFICANTES.": TipoDespesa.COMBUSTVEIS_E_LUBRIFICANTES,
  "DIVULGA????O DA ATIVIDADE PARLAMENTAR.":
      TipoDespesa.DIVULGAO_DA_ATIVIDADE_PARLAMENTAR,
  "MANUTEN????O DE ESCRIT??RIO DE APOIO ?? ATIVIDADE PARLAMENTAR":
      TipoDespesa.MANUTENO_DE_ESCRITRIO_DE_APOIO_ATIVIDADE_PARLAMENTAR,
  "PASSAGEM A??REA - REEMBOLSO": TipoDespesa.PASSAGEM_AREA_REEMBOLSO,
  "SERVI??OS POSTAIS": TipoDespesa.SERVIOS_POSTAIS,
  "TELEFONIA": TipoDespesa.TELEFONIA
});

enum TipoDocumento { NOTA_FISCAL_ELETRNICA, NOTA_FISCAL, RECIBOS_OUTROS }

final tipoDocumentoValues = EnumValues({
  "Nota Fiscal": TipoDocumento.NOTA_FISCAL,
  "Nota Fiscal Eletr??nica": TipoDocumento.NOTA_FISCAL_ELETRNICA,
  "Recibos/Outros": TipoDocumento.RECIBOS_OUTROS
});

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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));

    return reverseMap;
  }
}
