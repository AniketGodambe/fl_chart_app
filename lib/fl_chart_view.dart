import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FlChartViewPage extends StatefulWidget {
  const FlChartViewPage({super.key});

  @override
  State<FlChartViewPage> createState() => _FlChartViewPageState();
}

class _FlChartViewPageState extends State<FlChartViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var minY = linesData
        .expand((lineData) => lineData.map((point) => point.y))
        .reduce((min, y) => y < min ? y : min)
        .toDouble();
    var maxY = linesData
        .expand((lineData) => lineData.map((point) => point.y))
        .reduce((max, y) => y > max ? y : max)
        .toDouble();

    var minX = linesData
        .expand((lineData) => lineData.map((point) => point.x))
        .reduce((min, x) => x.isBefore(min) ? x : min)
        .millisecondsSinceEpoch
        .toDouble();
    var maxX = linesData
        .expand((lineData) => lineData.map((point) => point.x))
        .reduce((max, x) => x.isAfter(max) ? x : max)
        .millisecondsSinceEpoch
        .toDouble();

    log("minY $minY");
    log("maxY $maxY");
    log("minX $minX");
    log("maxX $maxX");

    var lineChartData = LineChartData(
      lineBarsData: linesData.asMap().entries.map((entry) {
        final index = entry.key;
        final lineData = entry.value;
        return LineChartBarData(
          spots: lineData
              .map((point) =>
                  FlSpot(point.x.millisecondsSinceEpoch.toDouble(), point.y))
              .toList(),
          isCurved: true,
          barWidth: 2,
          dotData: FlDotData(show: false), // Hide the dots
          color: lineColors[index], // Set the color for the line
        );
      }).toList(),
      minX: linesData
          .expand((lineData) => lineData.map((point) => point.x))
          .reduce((min, x) => x.isBefore(min) ? x : min)
          .millisecondsSinceEpoch
          .toDouble(),
      maxX: linesData
          .expand((lineData) => lineData.map((point) => point.x))
          .reduce((max, x) => x.isAfter(max) ? x : max)
          .millisecondsSinceEpoch
          .toDouble(),
      minY: minY - 0.5,
      maxY: maxY + 0.2,
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
            axisNameWidget: const Text("Dates"),
            axisNameSize: 20.0),
        leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true),
            axisNameWidget: const Text("Values"),
            axisNameSize: 20.0),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
    );

    var lineChartWidget = AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(lineChartData),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Graphs "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            SizedBox(
              child: Center(
                child: Container(
                    padding: const EdgeInsets.all(20), child: lineChartWidget),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<List<DataPoint>> linesData = [
    [
      DataPoint(DateTime.parse("2023-05-08T06:36:13.815Z"), 22.10),
      DataPoint(DateTime.parse("2023-05-09T06:36:13.815Z"), 22.20),
      DataPoint(DateTime.parse("2023-05-10T06:36:13.815Z"), 22.30),
      DataPoint(DateTime.parse("2023-05-11T06:36:13.815Z"), 22.40),
      DataPoint(DateTime.parse("2023-05-12T06:36:13.815Z"), 22.50),
      DataPoint(DateTime.parse("2023-05-13T06:36:13.815Z"), 22.60),
      DataPoint(DateTime.parse("2023-05-14T06:36:13.815Z"), 25.70),
      DataPoint(DateTime.parse("2023-05-15T06:36:13.815Z"), 22.80),
      DataPoint(DateTime.parse("2023-05-16T06:36:13.815Z"), 22.90),
      DataPoint(DateTime.parse("2023-05-17T06:36:13.815Z"), 23.00),
      DataPoint(DateTime.parse("2023-05-18T06:36:13.815Z"), 23.10),
      DataPoint(DateTime.parse("2023-05-19T06:36:13.815Z"), 23.20),
      DataPoint(DateTime.parse("2023-05-20T06:36:13.815Z"), 23.30),
      DataPoint(DateTime.parse("2023-05-21T06:36:13.815Z"), 23.40),
      DataPoint(DateTime.parse("2023-05-22T06:36:13.815Z"), 22.50),
      DataPoint(DateTime.parse("2023-05-23T06:36:13.815Z"), 22.60),
      DataPoint(DateTime.parse("2023-05-24T06:36:13.815Z"), 22.70),
      DataPoint(DateTime.parse("2023-05-25T06:36:13.815Z"), 22.80),
    ],
    [
      DataPoint(DateTime.parse("2023-05-08T06:36:13.815Z"), 20.20),
      DataPoint(DateTime.parse("2023-05-09T06:36:13.815Z"), 20.22),
      DataPoint(DateTime.parse("2023-05-10T06:36:13.815Z"), 20.29),
      DataPoint(DateTime.parse("2023-05-11T06:36:13.815Z"), 20.43),
      DataPoint(DateTime.parse("2023-05-12T06:36:13.815Z"), 20.45),
      DataPoint(DateTime.parse("2023-05-13T06:36:13.815Z"), 20.60),
      DataPoint(DateTime.parse("2023-05-14T06:36:13.815Z"), 20.20),
      DataPoint(DateTime.parse("2023-05-15T06:36:13.815Z"), 20.22),
      DataPoint(DateTime.parse("2023-05-16T06:36:13.815Z"), 20.29),
      DataPoint(DateTime.parse("2023-05-17T06:36:13.815Z"), 22.43),
      DataPoint(DateTime.parse("2023-05-18T06:36:13.815Z"), 20.45),
      DataPoint(DateTime.parse("2023-05-19T06:36:13.815Z"), 20.60),
      DataPoint(DateTime.parse("2023-05-20T06:36:13.815Z"), 20.20),
      DataPoint(DateTime.parse("2023-05-21T06:36:13.815Z"), 20.22),
      DataPoint(DateTime.parse("2023-05-22T06:36:13.815Z"), 20.29),
      DataPoint(DateTime.parse("2023-05-23T06:36:13.815Z"), 20.43),
      DataPoint(DateTime.parse("2023-05-24T06:36:13.815Z"), 20.45),
      DataPoint(DateTime.parse("2023-05-25T06:36:13.815Z"), 20.60),
    ],
    [
      DataPoint(DateTime.parse("2023-05-08T06:36:13.815Z"), 19.20),
      DataPoint(DateTime.parse("2023-05-09T06:36:13.815Z"), 19.22),
      DataPoint(DateTime.parse("2023-05-10T06:36:13.815Z"), 19.29),
      DataPoint(DateTime.parse("2023-05-11T06:36:13.815Z"), 19.43),
      DataPoint(DateTime.parse("2023-05-12T06:36:13.815Z"), 19.45),
      DataPoint(DateTime.parse("2023-05-13T06:36:13.815Z"), 19.60),
      DataPoint(DateTime.parse("2023-05-14T06:36:13.815Z"), 19.20),
      DataPoint(DateTime.parse("2023-05-15T06:36:13.815Z"), 19.22),
      DataPoint(DateTime.parse("2023-05-16T06:36:13.815Z"), 19.29),
      DataPoint(DateTime.parse("2023-05-17T06:36:13.815Z"), 19.43),
      DataPoint(DateTime.parse("2023-05-18T06:36:13.815Z"), 19.45),
      DataPoint(DateTime.parse("2023-05-19T06:36:13.815Z"), 19.60),
      DataPoint(DateTime.parse("2023-05-20T06:36:13.815Z"), 19.20),
      DataPoint(DateTime.parse("2023-05-21T06:36:13.815Z"), 19.22),
      DataPoint(DateTime.parse("2023-05-22T06:36:13.815Z"), 19.29),
      DataPoint(DateTime.parse("2023-05-23T06:36:13.815Z"), 19.43),
      DataPoint(DateTime.parse("2023-05-24T06:36:13.815Z"), 19.45),
      DataPoint(DateTime.parse("2023-05-25T06:36:13.815Z"), 19.60),
    ],
  ];

  final List<Color> lineColors = [
    const Color(0xff231E7C),
    const Color(0xffFABDAA),
    const Color(0xffd7f9b5),
  ];
}

class DataPoint {
  final DateTime x;
  final double y;

  DataPoint(this.x, this.y);
}
