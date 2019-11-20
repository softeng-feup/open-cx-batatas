import 'dart:async';
import 'package:flutter/material.dart';
import 'User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;


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
    zoom: 18.0,
    bearing: 90,
  );

  static final MinMaxZoomPreference zoomPreference = MinMaxZoomPreference(18.0, 100);

  static final CameraTargetBounds cameraBounds = CameraTargetBounds(
      LatLngBounds(southwest: LatLng(41.177421, -8.598519), northeast: LatLng(41.178487, -8.594044))
  );

  final AssetImage _map;
  User _user;
  String _mapStyle;

  MapController(this._map, this._user);

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('lib/assets/maps_style.json').then((string) {
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) { //"draw" method
    return Container(
      alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _feupPosition,
              minMaxZoomPreference: zoomPreference,
              myLocationEnabled: true,
              indoorViewEnabled: true,
              compassEnabled: false,
              cameraTargetBounds: cameraBounds,
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(_mapStyle);
                _controller.complete(controller);
              },
            ),
            Positioned(
              //TODO change so user position sticks to a latitude and longitude
              bottom: _user.yCoord + 50,
              left: _user.xCoord + 50,
              child: Icon(FontAwesomeIcons.solidSurprise),
            )
          ],
        )
    );
  }

}