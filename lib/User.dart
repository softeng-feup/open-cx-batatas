import 'package:tuple/tuple.dart';

class User {
  //Y vai desde 0 a 213 metros (corredor B)
  //X vai desde 0 a 65 metros (corredor B)
  //Só é preciso mapear o (0,0) e depois é adicionar os "pixeis" equivalentes a 1 metro na imagem
  double xCoord, yCoord;

  User (double x, double y) {
    xCoord = x;
    yCoord = y;
  }

  Tuple2<double, double> get getPosition {
    return Tuple2<double, double>(xCoord, yCoord);
  }
}