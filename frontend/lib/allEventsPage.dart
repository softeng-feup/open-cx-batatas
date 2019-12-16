import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'Classes.dart';

class AllEventsPage extends StatefulWidget {
  AllEventsPage({Key key}) : super(key: key);
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  List<Event> events = new List();

  List<Event> list23 = new List();
  List<Event> list24 = new List();
  List<Event> list25 = new List();
  List<Event> list26 = new List();

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  void fetchEvents() async {
    final response =
        await http.get('http://diogo98s.pythonanywhere.com/api/v1/events/');

    if (response.statusCode == 200) {
      var numEvents = jsonDecode(response.body).length;
      for (var i = 0; i < numEvents; i++) {
        Map<String, dynamic> jsonData = json.decode(response.body)[i];
        jsonData['is_bookmarked'] =
            false; // FIXME: add real value read from localStorage
        events.add(Event.fromJson(jsonData));
      }
      setState(() {
        buildDayLists();
      });
    } else {
      throw Exception('Failed to fetch events');
    }
  }

  void buildDayLists() {
    for (var i = 0; i < events.length; i++) {
      var dateParsedS = DateTime.parse(events[i].startTime);

      if (dateParsedS.day == 23) {
        list23.add(events[i]);
      }
      if (dateParsedS.day == 24) {
        list24.add(events[i]);
      }
      if (dateParsedS.day == 25) {
        list25.add(events[i]);
      }
      if (dateParsedS.day == 26) {
        list26.add(events[i]);
      }
    }
  }

  Widget dayList(List<Event> dayList) {
    final List<ListTile> dayTiles = new List();

    for (var i = 0; i < dayList.length; i++) {
      dayTiles.add(eventTile(dayList[i]));
    }

    return ListView(children: dayTiles);
  }

  String getCondensedTime(Event event) {
    var parsedStart = DateTime.parse(event.startTime);
    var parsedEnd = DateTime.parse(event.endTime);
    String condensed = parsedStart.hour.toString() +
        ":" +
        parsedStart.minute.toString() +
        "\n" +
        parsedEnd.hour.toString() +
        ":" +
        parsedEnd.minute.toString();

    return condensed;
  }

  ListTile eventTile(Event event) {
    var iconColor = Colors.black38;

    if (event.isBookmarked) {
      iconColor = Colors.orange;
    }

    return ListTile(
      //key: myKey,
      title: Text(event.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(event.description),
      leading: Text(getCondensedTime(event)),
      trailing: IconButton(
        icon: Icon(Icons.calendar_today, color: iconColor),
        onPressed: () {
          setState(() {
            event.toggleBookmark();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //"draw" method
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: '23 Mon'),
              Tab(text: '24 Tue'),
              Tab(text: '25 Wen'),
              Tab(text: '26 Thu'),
            ],
          ),
          title: Text('All events'),
        ),
        body: TabBarView(
          children: [
            dayList(list23),
            dayList(list24),
            dayList(list25),
            dayList(list26)
          ],
        ),
      ),
    );
  }
}
