import 'package:tuple/tuple.dart';

class User {
  double xCoord, yCoord;
  int floorN;

  User (double x, double y) {
    xCoord = x;
    yCoord = y;
  }

  Tuple2<double, double> get getPosition {
    return Tuple2<double, double>(xCoord, yCoord);
  }
}