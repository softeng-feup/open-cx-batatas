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
  Stairs(int floor, double latitude, double longitude) : super("Stairs", floor, "Coffe Machine: ", latitude, longitude);
}

class PlaceLists {
  List<Room> rooms;
  List<CoffeeMachine> coffees;
  List<Place > locations;

  PlaceLists.fromJSON(List<dynamic> parsedJsonList) {
    locations = parsedJsonList.map((i)=>Place.fromJSON(i)).toList();
    //Need to put correct locations in coffees and rooms
  }
}

class Beacon {
  final String macAddress;
  final double latitude, longitude;

  Beacon(this.macAddress, this.latitude, this.longitude);
}