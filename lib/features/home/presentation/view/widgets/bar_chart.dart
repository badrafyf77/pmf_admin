import 'package:pmf_admin/core/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class _BarChart extends StatelessWidget {
  const _BarChart({required this.date, required this.visitsList});

  final DateTime date;
  final List visitsList;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey[300],
            strokeWidth: 1,
          ),
        ),
        alignment: BarChartAlignment.spaceAround,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 0,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getLeftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(value.toInt().toString(), style: style),
    );
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 9,
    );
    String text;
    int month = date.month;
    switch (value.toInt()) {
      case 0:
        text = '01/$month';
        break;
      case 1:
        text = '02/$month';
        break;
      case 2:
        text = '03/$month';
        break;
      case 3:
        text = '04/$month';
        break;
      case 4:
        text = '05/$month';
        break;
      case 5:
        text = '06/$month';
        break;
      case 6:
        text = '07/$month';
        break;
      case 7:
        text = '08/$month';
        break;
      case 8:
        text = '09/$month';
        break;
      case 9:
        text = '10/$month';
        break;
      case 10:
        text = '11/$month';
        break;
      case 11:
        text = '12/$month';
        break;
      case 12:
        text = '13/$month';
        break;
      case 13:
        text = '14/$month';
        break;
      case 14:
        text = '15/$month';
        break;
      case 15:
        text = '16/$month';
        break;
      case 16:
        text = '17/$month';
        break;
      case 17:
        text = '18/$month';
        break;
      case 18:
        text = '19/$month';
        break;
      case 19:
        text = '20/$month';
        break;
      case 20:
        text = '21/$month';
        break;
      case 21:
        text = '22/$month';
        break;
      case 22:
        text = '23/$month';
        break;
      case 23:
        text = '24/$month';
        break;
      case 24:
        text = '25/$month';
        break;
      case 25:
        text = '26/$month';
        break;
      case 26:
        text = '27/$month';
        break;
      case 27:
        text = '28/$month';
        break;
      case 28:
        text = '29/$month';
        break;
      case 29:
        text = '30/$month';
        break;
      case 30:
        text = '31/$month';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      angle: AppUtils().degreeToRadian(value < 0 ? -45 : 45),
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getBottomTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            getTitlesWidget: getLeftTitles,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups {
    List<BarChartGroupData> barList = [];
    for (var i = 0; i < visitsList.length; i++) {
      int value = visitsList[i];
      barList.add(customBarChartGroupData(i, value.toDouble()));
    }
    return barList;
  }

  BarChartGroupData customBarChartGroupData(int index, double value) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: value,
          color: AppColors.kPrimaryColor,
        )
      ],
      showingTooltipIndicators: [0],
    );
  }
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3(
      {super.key, required this.date, required this.visitsList});

  final DateTime date;
  final List visitsList;

  @override
  State<BarChartSample3> createState() => _BarChartSample3State();
}

class _BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: _BarChart(
        date: widget.date,
        visitsList: widget.visitsList,
      ),
    );
  }
}

class AppUtils {
  factory AppUtils() {
    return _singleton;
  }

  AppUtils._internal();
  static final AppUtils _singleton = AppUtils._internal();

  double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }

  double radianToDegree(double radian) {
    return radian * 180 / math.pi;
  }
}
