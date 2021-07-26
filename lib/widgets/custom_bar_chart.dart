import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart_poc/models/rod_data.dart';
import 'package:flutter/material.dart';

class CustomBarChart extends StatelessWidget {
  final List<RodData> listRodData;
  final double maxX;
  final double maxY;
  final int intervaloEixoY;

  CustomBarChart(
      {required this.listRodData,
      required this.maxX,
      required this.maxY,
      required this.intervaloEixoY,
      Key? key})
      : super(key: key);

  List<BarChartGroupData> _getListBarChartGroupData(List<RodData> list) {
    List<BarChartGroupData> _listBarChartGroupData = [];

    for (var item in list) {
      List<BarChartRodData> _listBarChartRodData = [];

      for (var eixoY in item.listEixoY) {
        _listBarChartRodData.add(
          new BarChartRodData(
            y: eixoY.y,
            colors: [eixoY.color],
            width: eixoY.width,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        );
      }

      _listBarChartGroupData.add(
        new BarChartGroupData(
          x: item.eixoX,
          barsSpace: 4,
          barRods: _listBarChartRodData,
        ),
      );
    }

    return _listBarChartGroupData;
  }

  List<String> _getTitleEixoX(int tamanhoEixoX, final List<RodData> listRod) {
    int eixoX = tamanhoEixoX + 1;

    List<String> list = new List<String>.filled(eixoX, '', growable: true);

    for (var i = 0; i < eixoX; i++) {
      for (var item in listRod) {
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
    const Color _titleColor = Color(0xff000E23);
    final List<BarChartGroupData> _listBarChartGroupData =
        _getListBarChartGroupData(listRodData);

    return BarChart(
      BarChartData(
        maxY: maxY,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey,
            getTooltipItem: (_a, _b, _c, _d) => null,
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
          show: true,
          leftTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                color: _titleColor, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 32,
            reservedSize: 14,
            getTitles: (value) =>
                _getTitlesEixoY(maxY.toInt(), intervaloEixoY)[value.toInt()],
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            getTextStyles: (value) => const TextStyle(
                color: _titleColor, fontWeight: FontWeight.bold, fontSize: 14),
            margin: 20,
            getTitles: (value) =>
                _getTitleEixoX(maxX.toInt(), listRodData)[value.toInt()],
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: _backgroundLineColor,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        barGroups: _listBarChartGroupData,
      ),
    );
  }
}
