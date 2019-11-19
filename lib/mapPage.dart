import 'dart:async';
import 'package:flutter/material.dart';
import 'User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget {
  final AssetImage _map = AssetImage("lib/assets/images/FEUPmap.png");
  final User user = new User(10, 10);

  @override
  State<StatefulWidget> createState() {
    return MapController(_map, user);
  }
}

class MapController extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _feupPosition = CameraPosition(
    target: LatLng(41.177764, -8.596490),
    zoom: 14.4746,
  );
  final AssetImage _map;
  User _user;

  MapController(this._map, this._user);

  @override
  Widget build(BuildContext context) { //"draw" method
    return Container(
      alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _feupPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Positioned(
              bottom: _user.yCoord + 50,
              left: _user.xCoord + 50,
              child: Icon(FontAwesomeIcons.solidSurprise),
            )
          ],
        )
    );
  }

}