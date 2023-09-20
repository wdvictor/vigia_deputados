import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/doughnut_chart_sample_data.dart';

class DoughnutChartFullScreen extends StatefulWidget {
  const DoughnutChartFullScreen({Key? key, required this.chartData}) : super(key: key);
  final List<DoughnutChartSampleData> chartData;
  @override
  State<DoughnutChartFullScreen> createState() => _DoughnutChartFullScreenState();
}

class _DoughnutChartFullScreenState extends State<DoughnutChartFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorLib.primaryColor.color,
        shadowColor: Colors.transparent,
      ),
      body: SfCircularChart(
        title: ChartTitle(text: 'Distribuição de despesas'),
        legend: const Legend(
          position: LegendPosition.bottom,
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          shouldAlwaysShowScrollbar: true,
        ),
        series: <DoughnutSeries<DoughnutChartSampleData, String>>[
          DoughnutSeries(
              radius: '80%',
              explode: true,
              explodeOffset: '10%',
              dataSource: widget.chartData,
              xValueMapper: (datum, index) => datum.x,
              yValueMapper: (datum, index) => datum.y,
              startAngle: 90,
              endAngle: 90,
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
        ],
      ),
    );
  }
}
