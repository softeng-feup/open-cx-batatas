import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong/latlong.dart' as Lat;

import 'User.dart';

class Place {
  final String name;
  final int floor;
  final String type;
  final double latitude, longitude;
  //Also needs list of edges
  List<Place> _adj = List<Place>();

  Place(this.name, this.floor, this.type, this.latitude, this.longitude);

  factory Place.fromJSON(Map<String, dynamic> parsedJson){
    if(parsedJson['place_type'] == "ROOM") {
      return Room(parsedJson['name'], parsedJson['location']['floor'], parsedJson['location']['latitude'], parsedJson['location']['longitude']);
    }
    else if(parsedJson['place_type'] == "COFFEE") {
      return CoffeeMachine(parsedJson['name'], parsedJson['location']['floor'], parsedJson['location']['latitude'], parsedJson['location']['longitude']);
    }
    else if(parsedJson['place_type'] == "STAIRS") {
      return Stairs(parsedJson['name'], parsedJson['location']['floor'], parsedJson['location']['latitude'], parsedJson['location']['longitude']);
    }
    else if(parsedJson['place_type'] == "JOINT") {
      return Joint(parsedJson['name'], parsedJson['location']['floor'], parsedJson['location']['latitude'], parsedJson['location']['longitude']);
    }
    else return null;
  }

  void addAdj(Place place) {
    _adj.add(place);
  }

  static List<Place> getRoute(Place start, Place finish) {
    List<Place> path = List<Place>();

    bool buildRoute(Place current) {
      List<Place> adj = current._adj;

      for(int i = 0; i < adj.length; i++) {
        if(adj[i].name == finish.name) {
          path.add(finish);
          return true;
        }
        else if((adj[i] is Joint || adj[i] is Stairs) && (path.length <= 1 || adj[i].name != path[path.length - 2].name)){ //if next place is a path different from where we came
          path.add(adj[i]);
          if(buildRoute(adj[i])) return true;
          else path.removeLast();
        }
      }
      return false;
    }

    path.add(start);
    buildRoute(start);

    return path;
  }

  double calculateDistance(double lat, double long) {
    final Lat.Distance distance = new Lat.Distance();

    return distance(
        new Lat.LatLng(latitude,longitude),
        new Lat.LatLng(lat,long)
    );
  }

  static Place getNearestJoint(List<Place> places, User user) {
    Place nearest = places[0];
    double distance = places[0].calculateDistance(user.latitude, user.longitude);

    for(int i = 1; i < places.length; i++) {
      double newDist = places[i].calculateDistance(user.latitude, user.longitude);
      if(newDist < distance) {
        nearest = places[i];
        distance = newDist;
      }
    }

    return nearest;
  }
}

class Room extends Place {
  Room(String name, int floor, double latitude, double longitude) : super(name, floor, "Room: ", latitude, longitude);
  //Room will also display small list of next events if there are any
}

class CoffeeMachine extends Place {
  CoffeeMachine(String name, int floor, double latitude, double longitude) : super(name, floor, "Coffe Machine: ", latitude, longitude);
}

class Stairs extends Place {
  Stairs(String name, int floor, double latitude, double longitude) : super(name, floor, "Stairs: ", latitude, longitude);
}

class Joint extends Place {
  Joint(String name, int floor, double latitude, double longitude) : super(name, floor, "Joint: ", latitude, longitude);
}

class Beacon {
  final String macAddress;
  final double latitude, longitude;

  Beacon(this.macAddress, this.latitude, this.longitude);
}
