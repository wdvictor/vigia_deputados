import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vigia_deputados/helpers/color_lib.dart';
import 'package:vigia_deputados/models/chart_sample_data.dart';
import 'package:vigia_deputados/services/device_info.dart';

class DoughnutChartFullScreen extends StatefulWidget {
  const DoughnutChartFullScreen({Key? key, required this.chartData}) : super(key: key);
  final List<ChartSampleData> chartData;
  @override
  State<DoughnutChartFullScreen> createState() => _DoughnutChartFullScreenState();
}

class _DoughnutChartFullScreenState extends State<DoughnutChartFullScreen> {
  @override
  Widget build(BuildContext context) {
    final isTablet = DeviceInfo.isTablet(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorLib.primaryColor.color,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      body: SfCircularChart(
        title: ChartTitle(text: 'Distribuição de despesas'),
        legend: Legend(
          position: LegendPosition.bottom,
          isVisible: true,
          textStyle: GoogleFonts.dmSans(fontSize: isTablet ? 22 : 15),
          overflowMode: LegendItemOverflowMode.wrap,
          shouldAlwaysShowScrollbar: true,
        ),
        series: <DoughnutSeries<ChartSampleData, String>>[
          DoughnutSeries(
              radius: '80%',
              explode: true,
              explodeOffset: '10%',
              dataSource: widget.chartData,
              xValueMapper: (datum, index) => datum.x,
              yValueMapper: (datum, index) => datum.y,
              startAngle: 90,
              endAngle: 90,
              dataLabelSettings: DataLabelSettings(
                  textStyle: GoogleFonts.dmSans(fontSize: isTablet ? 22 : 15),
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside)),
        ],
      ),
    );
  }
}
