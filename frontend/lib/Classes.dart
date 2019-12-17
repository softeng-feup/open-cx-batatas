class Event {
  final int id;
  final String name;
  final String description;
  final String startTime;
  final String endTime;
  final String updates;
  bool isBookmarked;

  Event(
      {this.id,
      this.name,
      this.description,
      this.startTime,
      this.endTime,
      this.updates,
      this.isBookmarked});

  bool toggleBookmark() {
    if (this.isBookmarked) {
      this.isBookmarked = false;
    } else {
      this.isBookmarked = true;
    }
    return this.isBookmarked;
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        updates: json['updates'],
        isBookmarked: json['is_bookmarked']);
  }
}
