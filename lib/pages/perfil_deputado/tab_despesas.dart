import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class ChartSampleData {
  final String x;
  final double y;
  ChartSampleData(this.x, this.y);
}

class TabDespesas extends StatefulWidget {
  const TabDespesas({Key? key, required this.deputadoID}) : super(key: key);
  final int deputadoID;
  @override
  State<TabDespesas> createState() => _TabDespesasState();
}

class _TabDespesasState extends State<TabDespesas> {
  final CamaraApi _api = CamaraApi();
  List<ChartSampleData> chartData = [];
  void buildDoughnutData(List<DeputadoDespesasDado> dados) {
    for (var data in dados) {
      log(data.tipoDespesa);
      chartData.add(ChartSampleData(data.tipoDespesa.toString(), data.valorDocumento));
    }
  }

  @override
  Widget build(BuildContext context) {
    log(widget.deputadoID.toString());
    return Scaffold(
      body: FutureBuilder<DeputadoDespesas>(
        future: _api.getDeputadoDespesas(widget.deputadoID),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          buildDoughnutData(snapshot.data!.dados);
          return SfCircularChart(
            title: ChartTitle(text: 'Distribuição de despesas'),
            legend: const Legend(
              position: LegendPosition.right,
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              shouldAlwaysShowScrollbar: false,
            ),
            series: <DoughnutSeries<ChartSampleData, String>>[
              DoughnutSeries(
                  dataSource: chartData,
                  xValueMapper: (datum, index) => datum.x,
                  yValueMapper: (datum, index) => datum.y,
                  startAngle: 90,
                  endAngle: 90,
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
            ],
          );
        },
      ),
    );
  }
}
