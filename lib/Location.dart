class Location {
  final String name;
  final String floor;
  final String type;
  final double latitude, longitude;

  Location(this.name, this.floor, this.type, this.latitude, this.longitude);
}

class Room extends Location {
  Room(String name, String floor, double latitude, double longitude) : super(name, floor, "Room: ", latitude, longitude);
  //Room will also display small list of next events if there are any
}

class Event extends Location {
  Event(String name, String floor, double latitude, double longitude) : super(name, floor, "Event: ", latitude, longitude);
  //Event will also display location and time
}