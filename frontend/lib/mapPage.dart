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
import 'dart:math';
import 'package:maps_toolkit/maps_toolkit.dart' as mapToolkit;
import 'map/fetchers.dart';


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

  SearchBarController _searchBarController = new SearchBarController();

  /*
     0 - loading
     1 - no location permission
     2 - ready
  */
  int currentState;

  /* Origin location for meters cartesian representation */
  mapToolkit.LatLng REF_LOC = mapToolkit.LatLng(41.177958, -8.597342); // From A->B, top left corner

  /* Will hold scan results */
  final results = <String, ScanResult>{};

  /* Will hold available beacons */
  List<Beacon> beacons = new List<Beacon>();
  List<Place> places = new List<Place>();


  mapToolkit.LatLng b1;
  mapToolkit.LatLng b2;
  mapToolkit.LatLng b3;
  mapToolkit.LatLng actualMe;
  mapToolkit.LatLng calculatedMe;

  @override
  void initState() {
    super.initState();
    currentState = 0;

    checkLocationPermission();

    fetchAll();

    // TODO: Start scanning of BLE devices

    rootBundle.loadString('lib/assets/maps_style.json').then((string) {
      _mapStyle = string;
    });
  }

  /* Fetches required data from server */
  void fetchAll() async {
    fetchPlaces().then((p) => places = p);
    fetchBeacons().then((b) => beacons = b);
  }

  /* Updates the user location */
  void localizeUser() async {
    // Get the three closest beacons -- from last 10s
    beacons.sort((a, b) => a.distance.compareTo(b.distance));
  }

  /* Updates a Beacon's lastSeen and distance values */
  void updateBeaconInformation(final scanResult) async {
    var mp = -69;
    var ambient = 2;
    beacons.forEach((beacon) {
      if (beacon.macAddress == scanResult.deviceId) {
        beacon.updatedLastSeen = scanResult.time;
        beacon.updatedDistance = pow(10, (mp - scanResult.rssi)/(10 * ambient));
      }
    });
  }

  /* Keeps the results updated */
  void scanDevices() async {
      print("\n== Started BLE scan ==\n\n");
      await for (final scanResult in RxBle.startScan()) {
        results[scanResult.deviceId] = scanResult;
        print(scanResult);
        updateBeaconInformation(scanResult);
        // checkFound();
      }
      print("\n== Ended BLE scan ==\n\n");
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
      scanDevices();
    }
  }

  void requestLocationPermission() async {
    await RxBle.requestAccess();
    checkLocationPermission();
  }

  @override
  void dispose() {
    RxBle.stopScan();
    super.dispose();
  }

  Future<List<Place>> search(String searchStr) async {
    // print('\n\n\n');
    // print(beacons[0].macAddress);
    // print(beacons[0].lastSeen);
    // print(beacons[0].distance);
    // print('\n\n\n');
    // print(beacons[1].macAddress);
    // print(beacons[1].lastSeen);
    // print(beacons[1].distance);
    // print('\n\n\n');
    // print(beacons[2].macAddress);
    // print(beacons[2].lastSeen);
    // print(beacons[2].distance);
    // print('\n\n\n');
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

      Polyline r = Polyline(polylineId: PolylineId("start"), points: [LatLng(_user.latitude, _user.longitude), LatLng(path[0].latitude, path[0].longitude)], color: Colors.orange, zIndex: 0);
      routeSet.add(r);

      for(int i = 0; i < path.length - 1; i++) {
        Place place1 = path[i];
        Place place2 = path[i + 1];

        Polyline route = Polyline(polylineId: PolylineId(i.toString()), points: [LatLng(place1.latitude, place1.longitude), LatLng(place2.latitude, place2.longitude)], color: Colors.orange, zIndex: 0);
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

  mapToolkit.LatLng calculateCurrentPosition(mapToolkit.LatLng origin, mapToolkit.LatLng b1, mapToolkit.LatLng b2, mapToolkit.LatLng b3, double d1, double d2, double d3) {
    List<double> b1Meters = getMetersCoords(origin, b1);
    List<double> b2Meters = getMetersCoords(origin, b2);
    List<double> b3Meters = getMetersCoords(origin, b3);

    // FIXME: hardcoded values
    List<double> meMeters = getMetersCoords(origin, actualMe);
    double d1F = getDistanceBetween(b1Meters, meMeters);
    double d2F = getDistanceBetween(b2Meters, meMeters);
    double d3F = getDistanceBetween(b3Meters, meMeters);

    // Get 2 circle intersections
    List<double> intersections = intersection(b1Meters[0], b1Meters[1], d1F, b2Meters[0], b2Meters[1], d2F);

    // Which one of those is closest to b3?
    double i1Distance = getDistanceBetween([intersections[0], intersections[1]], b3Meters);
    double i2Distance = getDistanceBetween([intersections[2], intersections[3]], b3Meters);

    print('1: (' + intersections[0].toString() + ', ' + intersections[1].toString() + ')');
    print('2: (' + intersections[2].toString() + ', ' + intersections[3].toString() + ')');

    mapToolkit.LatLng one = getLatLngCoords(origin, intersections[0], intersections[1]);
    mapToolkit.LatLng two = getLatLngCoords(origin, intersections[2], intersections[3]);

    print('L1: (' + one.latitude.toString() + ', ' + one.longitude.toString() + ')');
    print('L2: (' + two.latitude.toString() + ', ' + two.longitude.toString() + ')');

    if (i1Distance < i2Distance) {
      return getLatLngCoords(origin, intersections[0], intersections[1]);
    } else {
      return getLatLngCoords(origin, intersections[2], intersections[3]);
    }
  }

  double getDistanceBetween(List<double> p1, List<double> p2) {
    return sqrt(pow(p2[1] - p1[1], 2) + pow(p2[0] - p1[0], 2));
  }

  mapToolkit.LatLng getLatLngCoords(mapToolkit.LatLng origin, double metersX, double metersY) {
    mapToolkit.LatLng coords = new mapToolkit.LatLng(mapToolkit.SphericalUtil.computeOffsetOrigin(origin, metersY, 0).latitude,
        mapToolkit.SphericalUtil.computeOffsetOrigin(origin, metersX, 270).longitude);
    return coords;
  }

  List<double> getMetersCoords(mapToolkit.LatLng origin, mapToolkit.LatLng place) {
    double metersX = mapToolkit.SphericalUtil.computeDistanceBetween(REF_LOC, new mapToolkit.LatLng(origin.latitude, place.longitude));
    double metersY = mapToolkit.SphericalUtil.computeDistanceBetween(REF_LOC, new mapToolkit.LatLng(place.latitude, origin.longitude));
    return [metersX, metersY];
  }

  List<double> intersection(x0, y0, r0, x1, y1, r1) {
    var a, dx, dy, d, h, rx, ry;
    var x2, y2;

    dx = x1 - x0;
    dy = y1 - y0;

    d = sqrt((dy*dy) + (dx*dx));

    if (d > (r0 + r1)) {
      /* no solution. circles do not intersect. */
      return [];
    }
    if (d < (r0 - r1).abs()) {
      /* no solution. one circle is contained in the other */
      return [];
    }

    a = ((r0*r0) - (r1*r1) + (d*d)) / (2.0 * d) ;

    x2 = x0 + (dx * a/d);
    y2 = y0 + (dy * a/d);

    h = sqrt((r0*r0) - (a*a));

    rx = -dy * (h/d);
    ry = dx * (h/d);

    var xi = x2 + rx;
    var xi_prime = x2 - rx;
    var yi = y2 + ry;
    var yi_prime = y2 - ry;

    return [xi, yi, xi_prime, yi_prime];
  }

  // TODO: give a better name
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
        zIndex: 1,
      );

      circles.add(circle);
    });
  }
}
