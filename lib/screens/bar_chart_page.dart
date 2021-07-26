import 'package:fl_chart_poc/models/rod_data.dart';
import 'package:fl_chart_poc/widgets/custom_bar_chart.dart';
import 'package:fl_chart_poc/widgets/indicator.dart';
import 'package:flutter/material.dart';

class BarChartPage extends StatelessWidget {
  final List<RodData> listRodData = [
    RodData(
      eixoX: 0,
      descricaoEixoX: 'P1',
      listEixoY: [
        EixoY(y: 5, width: 20, color: Color(0xff73B45A)),
        EixoY(y: 8, width: 20, color: Color(0xff1F2E4A)),
      ],
    ),
    RodData(
      eixoX: 1,
      descricaoEixoX: 'P2',
      listEixoY: [
        EixoY(y: 8, width: 20, color: Color(0xff73B45A)),
        EixoY(y: 7, width: 20, color: Color(0xff1F2E4A)),
      ],
    ),
    RodData(
      eixoX: 2,
      descricaoEixoX: 'P3',
      listEixoY: [
        EixoY(y: 8.5, width: 20, color: Color(0xff73B45A)),
        EixoY(y: 6.5, width: 20, color: Color(0xff1F2E4A)),
      ],
    ),
    RodData(
      eixoX: 3,
      descricaoEixoX: 'P4',
      listEixoY: [
        EixoY(y: 6, width: 20, color: Color(0xff73B45A)),
        EixoY(y: 10, width: 20, color: Color(0xff1F2E4A)),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bar chart')),
      body: AspectRatio(
        aspectRatio: 1.3,
        child: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Indicator(
                        color: listRodData[0].listEixoY[0].color,
                        text: 'Aluno',
                        isSquare: false,
                        size: 18,
                        textColor: Colors.black,
                      ),
                      Indicator(
                        color: listRodData[0].listEixoY[1].color,
                        text: 'Turma',
                        isSquare: false,
                        size: 18,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                      child: CustomBarChart(
                        listRodData: listRodData,
                        maxX: 10,
                        maxY: 10,
                        intervaloEixoY: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
