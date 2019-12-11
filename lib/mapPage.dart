import 'dart:async';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'Location.dart';
import 'User.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart' as Constants;

import 'package:permission_handler/permission_handler.dart';
import 'package:rx_ble/rx_ble.dart';
import 'package:loading/loading.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';


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

  //TODO precisa de ter as localizações da Feup pesquisaveis e mudar para o piso correto
  //TODO Precisa de um butão para determinar a rota para o local
  //TODO A rota pode ser calculada usando o google maps, a unica coisa a ter em atenção são as mudanças de pisos, que terão de ser feitas com pontos intermédios nas escadas
  //TODO butão para mostar todas as maquinas de café
  //TODO dar display a localização das outras pessoas
  //TODO expandir os icons de outras pessoas para uma imagem deles e ao carregar levar para o perfil deles

  GoogleMap map;
  Set<Circle> circles = new Set<Circle>();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Set<Marker> markerSet = new Set<Marker>();
  Set<Polyline> routeSet = new Set<Polyline>();

  List<Place> places = new List<Place>();
  SearchBarController _searchBarController = new SearchBarController();

  /*
     0 - loading
     1 - no location permission
     2 - ready
  */
  int currentState;

  @override
  void initState() {
    super.initState();
    currentState = 0;

    checkLocationPermission();

    fetchPlaces();
    // TODO: Start scanning of BLE devices

    rootBundle.loadString('lib/assets/maps_style.json').then((string) {
      _mapStyle = string;
    });
  }

  void checkLocationPermission() async {
    final PermissionStatus locationPerm = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
    bool enabled = (locationPerm == PermissionStatus.granted);

    if (!enabled) {
      setState(() {
        currentState = 1;
      });
    } else {
      setState(() {
        currentState = 2;
      });
    }
  }

  void requestLocationPermission() async {
    await RxBle.requestAccess();
    checkLocationPermission();
  }

  @override
  void dispose() {
    // TODO: Stop scanning of BLE devices
    super.dispose();
  }

  void fetchPlaces() async {
    final res = await http.get(Constants.API_URL + '/api/v1/places/');
    var data = json.decode(res.body) as List;

    places = data.map<Place>((json) => Place.fromJSON(json)).toList();

    final edges = await http.get(Constants.API_URL + '/api/v1/edges/');
    var edgeData = json.decode(edges.body) as List;

    //Go through every edge and get the origin from places and add the des
    for(int i = 0; i < edgeData.length; i++) {
      Map<String, dynamic> json = edgeData[i];
      String s1 = json['vertex1']['name'];
      String s2 = json['vertex2']['name'];

      Place p1, p2;
      for(int j = 0; j < places.length; j++) {
        if(places[j].name == s1) p1 = places[j];
        else if(places[j].name == s2) p2= places[j];
      }

      p1.addAdj(p2);
      p2.addAdj(p1);
    }
  }

  Future<List<Place>> search(String searchStr) async {
    return places.where((place) => place.name.toLowerCase().contains(searchStr.toLowerCase()) && place is Room).toList();
  }

  Container getMapContainer() {
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
                  myLocationButtonEnabled: true,
                  cameraTargetBounds: cameraBounds,
                  onMapCreated: (GoogleMapController controller) {
                    controller.setMapStyle(_mapStyle);
                    _controller.complete(controller);
                  },
                  circles: circles,
                  markers: markerSet,
                  polylines: routeSet,
                  mapToolbarEnabled: true,
              ),
              Center(
                  heightFactor: 1,
                  child: ListTileTheme(
                      style: ListTileStyle.list,
                      iconColor: Colors.blue,
                      selectedColor: Colors.red,
                      child: Container (
                          width: 360,
                          height: 300,
                          child: SearchBar(
                              //searchBarController: _searchBarController,
                              iconActiveColor: Colors.blue,
                              hintText: "Search location here",
                              hintStyle: TextStyle(
                                  color: Color.fromRGBO(212, 212, 212, 1),
                              ),
                              textStyle: TextStyle(
                                  color: Colors.black,
                              ),
                              placeHolder: SizedBox.shrink(),
                              loader: SizedBox.shrink(),
                              mainAxisSpacing: 10,
                              searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
                              listPadding: EdgeInsets.symmetric(horizontal: 10),
                              onSearch: search,
                              onItemFound: (Place place, int index) {
                                return Container(
                                    decoration: BoxDecoration(
                                        border: Border.fromBorderSide(BorderSide(color: Colors.blue)),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                    ),
                                    child: ListTile(
                                        title: Text(place.type + place.name),
                                        subtitle: Text("Floor: " + place.floor.toString()),
                                        onTap: () {this.markLocation(place);},
                                        trailing: Icon(Icons.location_on, color: Colors.deepOrange),
                                    ),
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
            ),
          ],
        )
    );
  }

  Container getLoadingContainer() {
    return Container(
        color: Colors.white,
        child: Center(
            child: Loading(indicator: BallPulseIndicator(), size: 100.0, color: Colors.lightBlue),
        ),
    );
  }

  Container getRequestLocationContainer() {
    return Container(
        color: Colors.white,
        child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FontAwesomeIcons.bluetoothB, size: 60, color: Colors.lightBlue), 
                  SizedBox(height: 20),
                  Text(
                      Constants.locationMissingStr,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ButtonTheme(
                      minWidth: 150.0,
                      height: 38.0,
                      buttonColor: Colors.grey[300],
                      child: RaisedButton(
                          onPressed: requestLocationPermission,
                          child: const Text(
                              'Grant permission',
                              style: TextStyle(fontSize: 16)
                          ),
                      ),
                  )
                ]
            )
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //TODO Preciso de ligar a localização retornada pelos beacons ao user
    this.updateUserLocation();

    switch (currentState) {
      case 0:
        return getLoadingContainer();
      case 1:
        return getRequestLocationContainer();
      case 2:
        return getMapContainer();
    }
  }

  void calculateRoute(Place finish) {
    Place start = Place.getNearestJoint(places, _user);
    List<Place> path = Place.getRoute(start, finish);

    setState(() {
      routeSet.clear();

      for(int i = 0; i < path.length - 1; i++) {
        Place place1 = path[i];
        Place place2 = path[i + 1];

        Polyline route = Polyline(polylineId: PolylineId(i.toString()), points: [LatLng(place1.latitude, place1.longitude), LatLng(place2.latitude, place2.longitude)]);
        routeSet.add(route);
      }

    });
  }

  void markLocation(Place place) async {
    setState(() {
      markerSet.clear();
      Marker marker = Marker(position: LatLng(place.latitude, place.longitude), markerId: MarkerId("markedLocation"),
                            icon: BitmapDescriptor.defaultMarkerWithHue(15), onTap: () => this.calculateRoute(place));
      markerSet.add(marker);
    });

    GoogleMapController controller = await _controller.future;
    CameraUpdate camera = CameraUpdate.newLatLngZoom(LatLng(place.latitude, place.longitude), 80.0);
    controller.animateCamera(camera);
  }

  void updateUserLocation() async {
    setState(() {
      circles.clear();
      Circle circle = Circle(
        circleId: CircleId("1"),
        center: LatLng(_user.latitude, _user.longitude),
        radius: 2,
        visible: true,
        fillColor: Colors.blue,
        strokeColor: Colors.deepOrange,
        strokeWidth: 2,
      );

      circles.add(circle);
    });
  }
}
