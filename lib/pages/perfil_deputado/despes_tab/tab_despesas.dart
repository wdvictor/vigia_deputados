import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/chart_sample_data.dart';
import 'package:vigia_deputados/models/deputado_despesa.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/doughnut_chart.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/doughnut_chart_fullscreen.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/line_chart.dart';
import 'package:vigia_deputados/pages/perfil_deputado/despes_tab/line_chart_full_screen.dart';
import 'package:vigia_deputados/services/device_info.dart';

class TabDespesas extends StatefulWidget {
  const TabDespesas({Key? key, required this.despesasDados}) : super(key: key);

  final List<DeputadoDespesasDado> despesasDados;
  @override
  State<TabDespesas> createState() => _TabDespesasState();
}

class _TabDespesasState extends State<TabDespesas> {
  List<ChartSampleData> doughnutchartData = [];
  List<ChartSampleData> lineChartData = [];
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

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
    _buildDoughnutData(widget.despesasDados);
    _buildLineData(widget.despesasDados);
    final isTablet = DeviceInfo.isTablet(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            thumbVisibility: true,
            thickness: 10,
            radius: const Radius.circular(20),
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  OpenContainer(
                      closedElevation: 0,
                      closedBuilder: (_, openContainer) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: IconButton(
                                  onPressed: openContainer,
                                  icon: Icon(
                                    Icons.open_in_full_sharp,
                                    size: isTablet ? 45 : 25,
                                  ),
                                ),
                              ),
                              Expanded(child: LineChart(lineChartData: lineChartData)),
                            ],
                          ),
                        );
                      },
                      openBuilder: (_, closeContainer) {
                        return LineChartFullScreen(lineChartData: lineChartData);
                      }),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          _scrollController.jumpTo(_scrollController.offset + 510);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          width: isTablet ? 200 : 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: ColorLib.primaryColor.color)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Ver mais',
                                style: GoogleFonts.dmSans(
                                    fontSize: isTablet ? 22 : 15, fontWeight: FontWeight.bold),
                              ),
                              const Icon(Icons.arrow_downward)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  OpenContainer(
                      closedElevation: 0,
                      closedBuilder: (_, openContainer) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: IconButton(
                                    onPressed: openContainer,
                                    icon: Icon(
                                      Icons.open_in_full_sharp,
                                      size: isTablet ? 45 : 25,
                                    )),
                              ),
                              Expanded(child: DoughnutChart(doughnutchartData: doughnutchartData))
                            ],
                          ),
                        );
                      },
                      openBuilder: (_, closeContainer) {
                        return DoughnutChartFullScreen(chartData: doughnutchartData);
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      '*Os gráficos são interativos',
                      style: GoogleFonts.dmSans(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
