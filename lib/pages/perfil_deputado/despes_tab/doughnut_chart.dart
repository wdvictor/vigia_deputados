import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vigia_deputados/models/chart_sample_data.dart';

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({Key? key, required this.doughnutchartData}) : super(key: key);
  final List<ChartSampleData> doughnutchartData;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.45,
      child: SfCircularChart(
        title: ChartTitle(text: 'Distribuição de despesas'),
        legend: const Legend(
          position: LegendPosition.bottom,
          isVisible: false,
          overflowMode: LegendItemOverflowMode.wrap,
          shouldAlwaysShowScrollbar: true,
        ),
        series: <DoughnutSeries<ChartSampleData, String>>[
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
    );
  }
}
