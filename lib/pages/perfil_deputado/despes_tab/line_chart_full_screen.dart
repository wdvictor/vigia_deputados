import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/chart_sample_data.dart';

class LineChartFullScreen extends StatelessWidget {
  const LineChartFullScreen({Key? key, required this.lineChartData}) : super(key: key);
  final List<ChartSampleData> lineChartData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorLib.primaryColor.color,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          title: ChartTitle(text: 'Despesas no tempo'),
          legend: const Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            position: LegendPosition.bottom,
          ),
          primaryXAxis: CategoryAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              interval: 2,
              majorGridLines: const MajorGridLines(width: 0)),
          primaryYAxis: NumericAxis(
            labelFormat: 'R\${value}',
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(color: Colors.transparent),
          ),
          series: <LineSeries<ChartSampleData, String>>[
            LineSeries(
              color: ColorLib.primaryColor.color,
              dataSource: lineChartData,
              xValueMapper: (datum, index) => datum.x,
              yValueMapper: (datum, index) => datum.y,
              width: 2,
              name: 'Gasto nos mêses',
              markerSettings: const MarkerSettings(isVisible: true),
            ),
          ],
          tooltipBehavior: TooltipBehavior(enable: true),
        ),
      ),
    );
  }
}
