class Place {
  final String name;
  final int floor;
  final String type;
  final double latitude, longitude;

  Place(this.name, this.floor, this.type, this.latitude, this.longitude);

  factory Place.fromJSON(Map<String, dynamic> parsedJson){
    if(parsedJson['place_type'] == "ROOM") {
      return Room(parsedJson['name'], parsedJson['location']['floor'], parsedJson['location']['latitude'], parsedJson['location']['longitude']);
    }
    else if(parsedJson['place_type'] == "COFFEE") {
      return CoffeeMachine(parsedJson['location']['floor'], parsedJson['location']['latitude'], parsedJson['location']['longitude']);
    }
    else if(parsedJson['place_type'] == "STAIRS") {
      return Stairs(parsedJson['location']['floor'], parsedJson['location']['latitude'], parsedJson['location']['longitude']);
    }
    else if(parsedJson['place_type'] == "JOINT") {
      return Joint(parsedJson['location']['floor'], parsedJson['location']['latitude'], parsedJson['location']['longitude']);
    }
    else return null;
  }
}

class Room extends Place {
  Room(String name, int floor, double latitude, double longitude) : super(name, floor, "Room: ", latitude, longitude);
  //Room will also display small list of next events if there are any
}

class CoffeeMachine extends Place {
  CoffeeMachine(int floor, double latitude, double longitude) : super("Coffee", floor, "Coffe Machine: ", latitude, longitude);
}

class Stairs extends Place {
  Stairs(int floor, double latitude, double longitude) : super("Stairs", floor, "Stairs: ", latitude, longitude);
}

class Joint extends Place {
  //Also needs list of edges
  List<Place> _adj = List<Place>();

  Joint(int floor, double latitude, double longitude) : super("Joint", floor, "Joint: ", latitude, longitude);

  void addAdj(Place place) {
    _adj.add(place);
  }

  static List<Place> getRoute(Joint start, Place finish) {
    List<Place> path = List<Place>();

    //Use Dijkstra to compute path
    //add start to path
    //check every adj place
    //check if any of them is the finish (if yes add it to end of path and break)
    //else go to the first adj and add it to the list
    //do the same for this place expect if the adj place is the same as the previous, continue until end is found or no more edges available
    //in which case the place is deleted from the path and we go back to the previous node and check the next adj place

    return path;
  }
}

class Beacon {
  final String macAddress;
  final double latitude, longitude;

  Beacon(this.macAddress, this.latitude, this.longitude);
}
