import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart_poc/models/spot.dart';
import 'package:flutter/material.dart';

class CustomLineChart extends StatelessWidget {
  final List<Spot> listCustomSpot = [
    Spot(eixoX: 1, eixoY: 8.1, descricaoEixoX: 'P.1'),
    Spot(eixoX: 4, eixoY: 5.6, descricaoEixoX: 'P.2'),
    Spot(eixoX: 7, eixoY: 9.0, descricaoEixoX: 'P.3'),
    Spot(eixoX: 10, eixoY: 3.1, descricaoEixoX: 'P.4'),
  ];

  final double minX = 0;
  final double maxX = 10;
  final double minY = 0;
  final double maxY = 10;
  final int intervaloEixoY = 2;

  CustomLineChart({Key? key}) : super(key: key);

  List<FlSpot> _getFlSpot(List<Spot> listSpot) {
    List<FlSpot> listFlSpot = [];

    for (var item in listSpot) listFlSpot.add(FlSpot(item.eixoX, item.eixoY));

    return listFlSpot;
  }

  List<int> _getListIndexes(int count) {
    List<int> list = [];
    for (var i = 0; i < count; i++) {
      list.add(i);
    }
    return list;
  }

  List<String> _getTitleEixoX(int tamanhoEixoX, List<Spot> listSpot) {
    int eixoX = tamanhoEixoX + 1;

    List<String> list = new List<String>.filled(eixoX, '', growable: true);

    for (var i = 0; i < eixoX; i++) {
      for (var item in listSpot) {
        if (i == item.eixoX) list[i] = item.descricaoEixoX;
      }
    }

    return list;
  }

  List<String> _getTitlesEixoY(int tamanhoEixoY, int intervalo) {
    int eixoY = tamanhoEixoY + 1;

    List<String> list = new List<String>.filled(eixoY, '', growable: true);

    for (var i = 0; i < eixoY; i++)
      if (i % intervalo == 0) list[i] = i.toString();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final Color _backgroundLineColor = Colors.grey[100]!;
    const Color _pointColor = Color(0xff063F5B);

    List<FlSpot> listFlSpots = _getFlSpot(listCustomSpot);

    List<int> listIndexes = _getListIndexes(listFlSpots.length);

    List<LineChartBarData> lineBarsData = [
      LineChartBarData(
        showingIndicators: listIndexes,
        spots: listFlSpots,
        isCurved: true,
        curveSmoothness: 0,
        colors: [Color(0xffB6B6B6)],
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return LineChart(
      LineChartData(
        showingTooltipIndicators: listIndexes.map((index) {
          return ShowingTooltipIndicators([
            LineBarSpot(tooltipsOnBar, lineBarsData.indexOf(tooltipsOnBar),
                tooltipsOnBar.spots[index]),
          ]);
        }).toList(),
        lineTouchData: LineTouchData(
          enabled: false,
          getTouchedSpotIndicator: (barData, spotIndexes) {
            return spotIndexes.map((spotIndex) {
              return TouchedSpotIndicatorData(
                FlLine(color: Colors.transparent, strokeWidth: 3),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 4,
                    color: Colors.white,
                    strokeColor: _pointColor,
                    strokeWidth: 4,
                  ),
                ),
              );
            }).toList();
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            tooltipRoundedRadius: 8,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                return LineTooltipItem(
                  lineBarSpot.y.toString(),
                  const TextStyle(
                      color: _pointColor, fontWeight: FontWeight.bold),
                );
              }).toList();
            },
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: _backgroundLineColor,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: _backgroundLineColor,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
              color: Color(0xff063F5B),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            getTitles: (value) =>
                _getTitlesEixoY(maxY.toInt(), intervaloEixoY)[value.toInt()],
            margin: 8,
            reservedSize: 30,
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            getTextStyles: (value) => const TextStyle(
              color: Color(0xff063F5B),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            margin: 10,
            getTitles: (value) =>
                _getTitleEixoX(maxX.toInt(), listCustomSpot)[value.toInt()],
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: _backgroundLineColor,
            ),
            left: BorderSide(
              color: _backgroundLineColor,
            ),
            right: BorderSide(
              color: _backgroundLineColor,
            ),
            top: BorderSide(
              color: _backgroundLineColor,
            ),
          ),
        ),
        minX: minX,
        maxX: maxX,
        minY: minY,
        maxY: maxY,
        lineBarsData: lineBarsData,
      ),
    );
  }
}
