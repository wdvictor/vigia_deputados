import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:vigia_deputados/models/chart_sample_data.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/doughnut_chart.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/doughnut_chart_fullscreen.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/line_chart.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/line_chart_full_screen.dart';
import 'package:vigia_deputados/services/camara_api.dart';

class TabDespesas extends StatefulWidget {
  const TabDespesas({Key? key, required this.deputadoID}) : super(key: key);
  final int deputadoID;
  @override
  State<TabDespesas> createState() => _TabDespesasState();
}

class _TabDespesasState extends State<TabDespesas> {
  final CamaraApi _api = CamaraApi();
  List<ChartSampleData> doughnutchartData = [];
  List<ChartSampleData> lineChartData = [];

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Janeiro';
      case 2:
        return 'Fevereiro';
      case 3:
        return 'Março';
      case 4:
        return 'Abril';
      case 5:
        return 'Maio';
      case 6:
        return 'Junho';
      case 7:
        return 'Julho';
      case 8:
        return 'Agosto';
      case 9:
        return 'Setembro';
      case 10:
        return 'Outubro';
      case 11:
        return 'Novembro';
      case 12:
        return 'Dezembro';
      default:
        return '';
    }
  }

  void _buildLineData(List<DeputadoDespesasDado> dados) {
    Map<int, double> lineData = {};
    for (var data in dados) {
      if (lineData[data.mes] == null) {
        lineData[data.mes] = data.valorDocumento;
      } else {
        lineData[data.mes] = data.valorDocumento + lineData[data.mes]!;
      }
    }
    var meses = lineData.keys.toList();
    meses.sort(((a, b) => a.compareTo(b)));
    if (lineChartData.isEmpty) {
      for (var mes in meses) {
        lineChartData.add(
          ChartSampleData(_getMonth(mes), lineData[mes]!),
        );
      }
    }
  }

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
            .add(ChartSampleData(data.key, double.parse(data.value.toStringAsFixed(2))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DeputadoDespesas>(
        future: _api.getDeputadoDespesas(widget.deputadoID, DateTime.now().year),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          _buildDoughnutData(snapshot.data!.dados);
          _buildLineData(snapshot.data!.dados);
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OpenContainer(closedBuilder: (_, openContainer) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: openContainer,
                            icon: const Icon(Icons.open_in_full_sharp),
                            color: Colors.grey,
                          ),
                          Expanded(child: LineChart(lineChartData: lineChartData))
                        ],
                      ),
                    );
                  }, openBuilder: (_, closeContainer) {
                    return LineChartFullScreen(lineChartData: lineChartData);
                  }),
                  OpenContainer(closedBuilder: (_, openContainer) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: openContainer,
                              icon: const Icon(
                                Icons.open_in_full_sharp,
                                color: Colors.grey,
                              )),
                          Expanded(child: DoughnutChart(doughnutchartData: doughnutchartData))
                        ],
                      ),
                    );
                  }, openBuilder: (_, closeContainer) {
                    return DoughnutChartFullScreen(chartData: doughnutchartData);
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
