import 'package:fl_chart_poc/screens/bar_chart_page.dart';
import 'package:flutter/material.dart';

import 'line_chart_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('FL Chart POC')),
        body: Container(
          color: const Color(0xffE5E5E5),
          padding: EdgeInsets.fromLTRB(8, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LineChartPage(),
                )),
                child: Text("Line chart"),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BarChartPage(),
                )),
                child: Text("Bar chart"),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
            ],
          ),
        ));
  }
}
