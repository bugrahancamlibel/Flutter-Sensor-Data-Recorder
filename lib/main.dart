import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sensor_data_logging/chart.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'accelerometer_data.dart';
import 'gyroscope_data.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensors Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<double>? _accelerometerValues;
  List<double>? _userAccelerometerValues;
  List<double>? _gyroscopeValues;
  List<double>? _magnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  List<AccelerometerData> _accelerometerData = [];
  List<GyroscopeData> _gyroscopeData = [];

  int backAndForth = 0;

  @override
  Widget build(BuildContext context) {
    final accelerometer =
    _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final gyroscope =
    _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        .toList();
    final magnetometer =
    _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Sensor Data'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.black38),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Accelerometer: $accelerometer'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('UserAccelerometer: $userAccelerometer'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Gyroscope: $gyroscope'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Magnetometer: $magnetometer'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Date: ${DateTime.now()}'),
              ],
            ),
          ),
          // a simple button to test the accelerometer
          ElevatedButton(
            child: const Text("Start"),
            onPressed: () {
              if(backAndForth % 2 == 1){
                _accelerometerData.clear();
                _gyroscopeData.clear();
              }
              // start a stream that saves acceleroemeterData
              _streamSubscriptions.add(
                  accelerometerEvents.listen((AccelerometerEvent event) {
                    _accelerometerData.add(AccelerometerData(DateTime.now(), <double>[event.x, event.y, event.z]));
                  })
              );
              // start a stream that saves gyroscopeData
              _streamSubscriptions.add(
                  gyroscopeEvents.listen((GyroscopeEvent event) {
                    _gyroscopeData.add(GyroscopeData(DateTime.now(), <double>[event.x, event.y, event.z]));
                  })
              );
              backAndForth++;
            },
          ),
          ElevatedButton(
            child: const Text("Stop"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              print("length: ${_accelerometerData.length}");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChartScreen(accelerometerData: _accelerometerData, gyroscopeData: _gyroscopeData)),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(
      accelerometerEvents.listen(
            (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
            (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
            (UserAccelerometerEvent event) {
          setState(() {
            _userAccelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      magnetometerEvents.listen(
            (MagnetometerEvent event) {
          setState(() {
            _magnetometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }
}