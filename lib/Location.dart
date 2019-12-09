class Location {
  final String name;
  final int floor;
  final String type;
  final double latitude, longitude;

  Location(this.name, this.floor, this.type, this.latitude, this.longitude);

  factory Location.fromJSON(Map<String, dynamic> parsedJson){
    if(parsedJson['type'] == "room") {
      return Room(parsedJson['name'], parsedJson['floor'], parsedJson['latitude'], parsedJson['longitude']);
    }
    else if(parsedJson['type'] == "coffee") {
      return CoffeeMachine(parsedJson['floor'], parsedJson['latitude'], parsedJson['longitude']);
    }
    else if(parsedJson['type'] == "stairs") {
      return Stairs(parsedJson['floor'], parsedJson['latitude'], parsedJson['longitude']);
    }
    else return null;
  }
}

class Room extends Location {
  Room(String name, int floor, double latitude, double longitude) : super(name, floor, "Room: ", latitude, longitude);
  //Room will also display small list of next events if there are any
}

class CoffeeMachine extends Location {
  CoffeeMachine(int floor, double latitude, double longitude) : super("Coffee", floor, "Coffe Machine: ", latitude, longitude);
}

class Stairs extends Location {
  Stairs(int floor, double latitude, double longitude) : super("Stairs", floor, "Coffe Machine: ", latitude, longitude);
}

class LocationLists {
  List<Room> rooms;
  List<CoffeeMachine> coffees;
  List<Location> locations;

  LocationLists.fromJSON(List<dynamic> parsedJsonList) {
    locations = parsedJsonList.map((i)=>Location.fromJSON(i)).toList();
    //Need to put correct locations in coffees and rooms
  }
}