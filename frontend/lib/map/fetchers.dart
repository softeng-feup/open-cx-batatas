import '../Location.dart';
import '../constants.dart' as Constants;
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Beacon>> fetchBeacons() async {
  final res = await http.get(Constants.API_URL + '/api/v1/beacons/');
  var data = json.decode(res.body) as List;
  List<Beacon> beacons = data.map<Beacon>((json) => Beacon.fromJSON(json)).toList();
  return beacons;
}

Future<List<Place>> fetchPlaces() async {
  final res = await http.get(Constants.API_URL + 'places/');
  var data = json.decode(res.body) as List;

  List<Place> places = data.map<Place>((json) => Place.fromJSON(json)).toList();

  final edges = await http.get(Constants.API_URL + 'edges/');
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

  return places;
}
