import 'dart:async';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'Location.dart';
import 'User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;


class MapPage extends StatefulWidget {
  final User user = new User(41.177764, -8.596490);

  @override
  State<StatefulWidget> createState() {
    return MapController(user);
  }
}

class MapController extends State<MapPage> {
  MapController(this._user);

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
  User _user;
  String _mapStyle;

  //TODO Preciso de localização de user (Usar markers n está a dar, talvez usar uma imagem como overlay mas tenho o problema de passar latitudee longitude para ecrã + zoom e cenas)
  //TODO Preciso de ligar a localização retornada pelos beacons ao user
  //TODO Precisa de uma search bar e colocar um marker no sitio pesquisado
  //TODO Precisa de um butão para determinar a rota para o local
  //TODO butão para mostar todas as maquinas de café
  //TODO dar display a localização das outras pessoas
  //TODO expandir os icons de outras pessoas para uma imagem deles e ao carregar levar para o perfil deles

  GoogleMap map;
  Set<Circle> circles;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0.5, 0.5)), 'lib/assets/images/userIcon.png').then((onValue) {
          Marker marker = Marker(position: LatLng(_user.xCoord, _user.yCoord), markerId: MarkerId("UserLocation"));
          markers[MarkerId("UserLocation")] = marker;
    });

    rootBundle.loadString('lib/assets/maps_style.json').then((string) {
      _mapStyle = string;

      circles = Set.from([Circle(
        circleId: CircleId("1"),
        center: LatLng(_user.xCoord, _user.yCoord),
        radius: 4000,
      )]);
    });

    map = GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _feupPosition,
      minMaxZoomPreference: zoomPreference,
      myLocationEnabled: true,
      indoorViewEnabled: true,
      compassEnabled: false,
      myLocationButtonEnabled: true,
      cameraTargetBounds: cameraBounds,
      onMapCreated: (GoogleMapController controller) {
        controller.setMapStyle(_mapStyle);
        _controller.complete(controller);
      },
      circles: circles,
    );

  }

  Future<List<Location>> search(String search) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(search.length, (int index) {
      return Location(
        "Title : $search $index",
        "Description :$search $index",
        "Undefined"
      );
    });
  }

  @override
  Widget build(BuildContext context) { //"draw" method
    return Container(
      alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            map,
            Center(
              heightFactor: 1,
              child: Container (
                width: 360,
                height: 300,
                child: SearchBar(
                  onSearch: search,
                  onItemFound: (Location post, int index) {
                    return ListTile(
                      title: Text(post.name),
                      subtitle: Text(post.floor),
                    );
                  },
                  searchBarStyle: SearchBarStyle(
                    backgroundColor: Color.fromRGBO(255, 255, 255, .95),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    padding: EdgeInsets.all(5.0),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}