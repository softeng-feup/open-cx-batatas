import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'Classes.dart';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

typedef UpdateBookmark = void Function({int eventId, bool isBookmarked});

class AllEventsPage extends StatelessWidget {
  AllEventsPage(
      {Key key,
      this.eventsReady,
      this.events,
      this.bookmarkIds,
      this.list23,
      this.list24,
      this.list25,
      this.list26,
      this.updateBookmark})
      : super(key: key);

  bool eventsReady;
  List<Event> events;
  List<int> bookmarkIds;
  List<Event> list23;
  List<Event> list24;
  List<Event> list25;
  List<Event> list26;
  final UpdateBookmark updateBookmark;

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
      title: Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(event.name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ))),
      subtitle: Padding(
          padding: EdgeInsets.only(top: 10), child: Text(event.description)),
      leading: Text(getCondensedTime(event)),
      trailing: IconButton(
        icon: Icon(Icons.calendar_today, color: iconColor),
        onPressed: () {
          bool isBookmarked = event.toggleBookmark();
          updateBookmark(eventId: event.id, isBookmarked: isBookmarked);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (eventsReady) {
      return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
              flexibleSpace:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            TabBar(
              tabs: [
                Tab(text: '23 Mon'),
                Tab(text: '24 Tue'),
                Tab(text: '25 Wen'),
                Tab(text: '26 Thu'),
              ],
            ),
          ])),
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
    } else {
      return Container(color: Colors.white);
    }
  }
}
