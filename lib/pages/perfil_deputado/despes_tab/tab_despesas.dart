import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/models/doughnut_chart_sample_data.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/doughnut_chart_fullscreen.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class TabDespesas extends StatefulWidget {
  const TabDespesas({Key? key, required this.deputadoID}) : super(key: key);
  final int deputadoID;
  @override
  State<TabDespesas> createState() => _TabDespesasState();
}

class _TabDespesasState extends State<TabDespesas> {
  final CamaraApi _api = CamaraApi();
  List<DoughnutChartSampleData> doughnutchartData = [];

  void _buildDoughnutData(List<DeputadoDespesasDado> dados) {
    Map<String, double> dataMap = {};
    for (var data in dados) {
      if (dataMap[data.tipoDespesa] != null) {
        dataMap[data.tipoDespesa] = data.valorDocumento + dataMap[data.tipoDespesa]!;
      } else {
        dataMap[data.tipoDespesa] = data.valorDocumento;
      }
    }
    if (doughnutchartData.isEmpty) {
      for (var data in dataMap.entries) {
        doughnutchartData
            .add(DoughnutChartSampleData(data.key, double.parse(data.value.toStringAsFixed(2))));
      }
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

          _buildDoughnutData(snapshot.data!.dados);
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DoughnutChartFullScreen(chartData: doughnutchartData),
                            ),
                          ),
                      icon: const Icon(Icons.open_in_full_rounded)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: SfCircularChart(
                      title: ChartTitle(text: 'Distribuição de despesas'),
                      legend: const Legend(
                        position: LegendPosition.bottom,
                        isVisible: false,
                        overflowMode: LegendItemOverflowMode.wrap,
                        shouldAlwaysShowScrollbar: true,
                      ),
                      series: <DoughnutSeries<DoughnutChartSampleData, String>>[
                        DoughnutSeries(
                            radius: '50%',
                            explode: true,
                            explodeOffset: '10%',
                            dataSource: doughnutchartData,
                            xValueMapper: (datum, index) => datum.x,
                            yValueMapper: (datum, index) => datum.y,
                            dataLabelMapper: (datum, index) => datum.x,
                            startAngle: 90,
                            endAngle: 90,
                            dataLabelSettings: const DataLabelSettings(
                                isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
                      ],
                    ),
                  ),
                  const SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
