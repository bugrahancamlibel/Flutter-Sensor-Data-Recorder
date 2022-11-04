class GyroscopeData {
  final DateTime date;
  final List<double> value;

  GyroscopeData(this.date, this.value);

  DateTime get getDate => date;
  List<double> get getValue => value;

}