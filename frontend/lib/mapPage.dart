import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class MapPage extends StatefulWidget {
  final AssetImage _map = AssetImage("lib/assets/images/FEUPmap.png");

  @override
  State<StatefulWidget> createState() {
    return MapController(_map);
  }
}

class MapController extends State<MapPage> {
  Matrix4 _matrix = Matrix4.translationValues(0, 0, 0);
  final AssetImage _map;

  MapController(this._map);

  @override
  Widget build(BuildContext context) {
    //"draw" method
    return Container(
        alignment: Alignment.center,
        child: SizedBox.expand(
            child: MatrixGestureDetector(
                onMatrixUpdate:
                    (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
                  setState(() {
                    _matrix = m;
                  });
                },
                child:
                    Transform(transform: _matrix, child: Image(image: _map)))));
  }
}
