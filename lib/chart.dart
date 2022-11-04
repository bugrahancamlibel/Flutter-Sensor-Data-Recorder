import 'package:flutter/material.dart';
import 'accelerometer_data.dart';
import 'gyroscope_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key, required this.accelerometerData, required this.gyroscopeData}) : super(key: key);
  final List<AccelerometerData> accelerometerData;
  final List<GyroscopeData> gyroscopeData;

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Data Charts'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Acceleration Sensor Data'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: false),
              series: <ChartSeries<AccelerometerData, DateTime>>[
                LineSeries<AccelerometerData, DateTime>(
                    dataSource: widget.accelerometerData,
                    xValueMapper: (AccelerometerData value, _) => value.getDate,
                    yValueMapper: (AccelerometerData value, _) => value.getValue[0],
                    name: 'X',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true)),
                LineSeries<AccelerometerData, DateTime>(
                    dataSource: widget.accelerometerData,
                    xValueMapper: (AccelerometerData value, _) => value.getDate,
                    yValueMapper: (AccelerometerData value, _) => value.getValue[1],
                    name: 'Y',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true)),
                LineSeries<AccelerometerData, DateTime>(
                    dataSource: widget.accelerometerData,
                    xValueMapper: (AccelerometerData value, _) => value.getDate,
                    yValueMapper: (AccelerometerData value, _) => value.getValue[2],
                    name: 'Z',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
          SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              // Chart title
              title: ChartTitle(text: 'Gyroscope Sensor Data'),
              // Enable legend
              legend: Legend(isVisible: true),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: false),
              series: <ChartSeries<GyroscopeData, DateTime>>[
                LineSeries<GyroscopeData, DateTime>(
                    dataSource: widget.gyroscopeData,
                    xValueMapper: (GyroscopeData value, _) => value.getDate,
                    yValueMapper: (GyroscopeData value, _) => value.getValue[0],
                    name: 'X',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true)),
                LineSeries<GyroscopeData, DateTime>(
                    dataSource: widget.gyroscopeData,
                    xValueMapper: (GyroscopeData value, _) => value.getDate,
                    yValueMapper: (GyroscopeData value, _) => value.getValue[1],
                    name: 'Y',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true)),
                LineSeries<GyroscopeData, DateTime>(
                    dataSource: widget.gyroscopeData,
                    xValueMapper: (GyroscopeData value, _) => value.getDate,
                    yValueMapper: (GyroscopeData value, _) => value.getValue[2],
                    name: 'Z',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     //Initialize the spark charts widget
          //     child: SfSparkLineChart.custom(
          //       //Enable the trackball
          //       trackball: SparkChartTrackball(
          //           activationMode: SparkChartActivationMode.tap),
          //       //Enable marker
          //       marker: SparkChartMarker(
          //           displayMode: SparkChartMarkerDisplayMode.all),
          //       //Enable data label
          //       labelDisplayMode: SparkChartLabelDisplayMode.all,
          //       xValueMapper: (int index) => data[index].year,
          //       yValueMapper: (int index) => data[index].sales,
          //       dataCount: 5,
          //     ),
          //   ),
          // )
        ]));
  }
}
