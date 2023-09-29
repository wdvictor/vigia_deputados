import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/chart_sample_data.dart';
import 'package:vigia_deputados/services/device_info.dart';

class LineChart extends StatelessWidget {
  const LineChart({Key? key, required this.lineChartData}) : super(key: key);
  final List<ChartSampleData> lineChartData;
  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceInfo.isTablet(context);
    return Container(
      margin: const EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.45,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(
            text: 'Despesas no tempo',
            textStyle: GoogleFonts.dmSans(fontSize: isTablet ? 20 : 15, color: Colors.grey[600])),
        legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: GoogleFonts.dmSans(fontSize: isTablet ? 25 : 15),
          position: LegendPosition.bottom,
        ),
        primaryXAxis: CategoryAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            interval: 1,
            labelStyle: GoogleFonts.dmSans(fontSize: isTablet ? 22 : 15),
            majorGridLines: const MajorGridLines(width: 0)),
        primaryYAxis: NumericAxis(
          labelFormat: 'R\$ {value}',
          axisLine: const AxisLine(width: 0),
          labelStyle: GoogleFonts.dmSans(fontSize: isTablet ? 22 : 15),
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
    );
  }
}
