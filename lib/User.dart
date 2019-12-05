import 'package:tuple/tuple.dart';

class User {
  double latitude, longitude;
  int floorN;

  User (double x, double y) {
    latitude = x;
    longitude = y;
  }

  Tuple2<double, double> get getPosition {
    return Tuple2<double, double>(latitude, longitude);
  }
}