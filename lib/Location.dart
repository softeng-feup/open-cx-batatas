class Location {
  final String name;
  final String floor;
  final String type;

  Location(this.name, this.floor, this.type);
}

class Room extends Location {
  Room(String name, String floor) : super(name, floor, "Room: ");
  //Room will also display small list of next events if there are any
}

class Event extends Location {
  Event(String name, String floor) : super(name, floor, "Event: ");
  //Event will also display location and time
}