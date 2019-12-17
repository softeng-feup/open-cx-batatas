import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'Classes.dart';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class AllEventsPage extends StatefulWidget {
  AllEventsPage({Key key}) : super(key: key);
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  List<Event> events = new List();
  List<int> bookmarkIds = new List();

  List<Event> list23 = new List();
  List<Event> list24 = new List();
  List<Event> list25 = new List();
  List<Event> list26 = new List();

  @override
  void initState() {
    super.initState();
    // TODO: add loading state
    fetchEvents();
  }

  void fetchEvents() async {
    final response = await http.get(
        'http://diogo98s.pythonanywhere.com/api/v1/events/',
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      var utf8Data = utf8.decode(response.bodyBytes);
      var numEvents = jsonDecode(utf8Data).length;

      await updateBookmarksFromStorage();

      for (var i = 0; i < numEvents; i++) {
        Map<String, dynamic> jsonData = json.decode(response.body)[i];

        if (bookmarkIds.contains(jsonData['id'])) {
          jsonData['is_bookmarked'] = true;
        } else {
          jsonData['is_bookmarked'] = false;
        }

        events.add(Event.fromJson(jsonData));
      }

      setState(() {
        buildDayLists();
      });
    } else {
      throw Exception('Failed to fetch events');
    }
  }

  /* Updates bookmarks information from storage */
  Future updateBookmarksFromStorage() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File bookmarksFile = File('$path/bookmarks.txt'); // TODO: add to Constants

    try {
      String bookmarksFileContents = await bookmarksFile.readAsString();
      Map<String, dynamic> bookmarksJson = json.decode(bookmarksFileContents);

      int numBookmarks = bookmarksJson['bookmarks'].length;
      for (var i = 0; i < numBookmarks; i++) {
        bookmarkIds.add(bookmarksJson['bookmarks'][i]);
      }
    } catch (e) {
      return null;
    }
  }

  /* Saves bookmarks information to storage */
  void saveBookmarksToStorage() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    File bookmarksFile = File('$path/bookmarks.txt'); // TODO: add to Constants
    bookmarksFile.writeAsString(json.encode({'bookmarks': bookmarkIds}));
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

  void updateBookmark({int eventId, bool isBookmarked}) {
    if (isBookmarked) {
      if (!bookmarkIds.contains(eventId)) {
        bookmarkIds.add(eventId);
      }
    } else {
      if (bookmarkIds.contains(eventId)) {
        bookmarkIds.remove(eventId);
      }
    }
    saveBookmarksToStorage();
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

    // print(event.description);

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
            bool isBookmarked = event.toggleBookmark();
            updateBookmark(eventId: event.id, isBookmarked: isBookmarked);
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
