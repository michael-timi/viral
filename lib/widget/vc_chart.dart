import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:viral/models/vc_chart.dart';
import 'package:viral/widget/colors.dart';

// ignore: camel_case_types
class VC_Chart extends StatefulWidget {
  final Widget child;

  VC_Chart({Key key, this.child}) : super(key: key);

  @override
  _VC_ChartState createState() => _VC_ChartState();
}

// ignore: camel_case_types
class _VC_ChartState extends State<VC_Chart> {
  List<charts.Series<Sales, int>> _seriesLineData;

  _generateData() {
    var linesalesdata = [
      new Sales(5, 45),
      new Sales(10, 56),
      new Sales(15, 55),
      new Sales(20, 60),
      new Sales(25, 61),
      new Sales(30, 70),
    ];
    var linesalesdata1 = [
      new Sales(5, 35),
      new Sales(10, 46),
      new Sales(15, 45),
      new Sales(20, 50),
      new Sales(25, 51),
      new Sales(30, 60),
    ];

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff109618)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Container(
        height: width / 2,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0), color: white),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: charts.LineChart(
                _seriesLineData,
                defaultRenderer:
                    charts.LineRendererConfig(includeArea: true, stacked: true),
                animate: true,
                animationDuration: Duration(seconds: 1),
                behaviors: [
                  charts.ChartTitle('Days',
                      behaviorPosition: charts.BehaviorPosition.bottom,
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
                  charts.ChartTitle('(Clicks, Views)',
                      behaviorPosition: charts.BehaviorPosition.start,
                      titleOutsideJustification:
                          charts.OutsideJustification.middleDrawArea),
//                  charts.ChartTitle('Departments',
//                      behaviorPosition: charts.BehaviorPosition.end,
//                      titleOutsideJustification:
//                          charts.OutsideJustification.middleDrawArea),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
