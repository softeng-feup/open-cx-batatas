import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MapPage extends StatefulWidget {
  final AssetImage _map = AssetImage("lib/assets/images/FEUPmap.png");
  User user = new User(10, 10);

  @override
  State<StatefulWidget> createState() {
    return MapController(_map, user);
  }
}

class MapController extends State<MapPage> {
  Matrix4 _matrix = Matrix4.translationValues(0, 0, 0);
  final AssetImage _map;
  User _user;

  MapController(this._map, this._user);

  @override
  Widget build(BuildContext context) { //"draw" method
    return Container(
      alignment: Alignment.center,
        child: SizedBox.expand(
            child: MatrixGestureDetector(
                onMatrixUpdate: (Matrix4 m, Matrix4 tm, Matrix4 sm, Matrix4 rm) {
                  setState(() {
                    _matrix = m;
                  });
                },
                child: Transform(
                    transform: _matrix,
                    child: Stack(
                      children: <Widget>[
                        //Background Map
                        Image(image: _map),
                        //List of users overlay
                        //...
                        //Main User Overlay
                        Positioned(
                          bottom: _user.yCoord + 50,
                          left: _user.xCoord + 50,
                          child: Icon(FontAwesomeIcons.solidSurprise),
                        )
                      ],
                    )
                )
            )
        )
    );
  }

}