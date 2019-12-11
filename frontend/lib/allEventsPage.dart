import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

/*Future<Post> fetchPost() async {
  final response =
      await http.get('http://diogo98s.pythonanywhere.com/api/v1/events/');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body)[0]);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}*/

//List<_tile> fazTiles() {

//}

//Widget _buildCenas() => ListView(
//children: buildPosts(posts),
//)

class Post {
  final int id;
  final String name;
  final String description;
  final String start_time;
  final String end_time;
  final String updates;

  Post(
      {this.id,
      this.name,
      this.description,
      this.start_time,
      this.end_time,
      this.updates});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      start_time: json['start_time'],
      end_time: json['end_time'],
      updates: json['updates'],
    );
  }
}

class AllEventsPage extends StatefulWidget {
  AllEventsPage({Key key}) : super(key: key);
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  var cores = {};
  var isEnabled = {};

  List<Post> posts = new List();
  List<ListTile> list_23;
  List<ListTile> list_24;
  List<ListTile> list_25;
  List<ListTile> list_26;

  @override
  void initState() {
    super.initState();
    list_23 = new List();
    list_24 = new List();
    list_25 = new List();
    list_26 = new List();
    fetchPost();
  }

  void fetchPost() async {
    final response =
        await http.get('http://diogo98s.pythonanywhere.com/api/v1/events/');

    if (response.statusCode == 200) {
      var sizeOf_post = jsonDecode(response.body).length;
      // If the call to the server was successful, parse the JSON.
      for (var i = 0; i < sizeOf_post; i++) {
        posts.add(Post.fromJson(json.decode(response.body)[i]));
      }
      _buildDayList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  // Find days and spare events by day function
  void _buildDayList() {
    for (var i = 0; i < posts.length; i++) {
      var id = posts[i].id;
      var dateParsedS = DateTime.parse(posts[i].start_time);
      var dateParsedE = DateTime.parse(posts[i].end_time);
      var n = posts[i].name;
      var d = posts[i].description;
      var time_conden = dateParsedS.hour.toString() +
          ":" +
          dateParsedS.minute.toString() +
          "\n" +
          dateParsedE.hour.toString() +
          ":" +
          dateParsedE.minute.toString();

      if (dateParsedS.day == 23) {
        var newTile = _tile(n, d, time_conden, id);
        setState(() {
          list_23.add(newTile);
          list_23 = List.from(list_23);
        });
      }
      if (dateParsedS.day == 24) {
        var newTile = _tile(n, d, time_conden, id);
        setState(() {
          list_24.add(newTile);
        });
      }
      if (dateParsedS.day == 25) {
        var newTile = _tile(n, d, time_conden, id);
        setState(() {
          list_25.add(newTile);
        });
      }
      if (dateParsedS.day == 26) {
        var newTile = _tile(n, d, time_conden, id);
        setState(() {
          list_26.add(newTile);
        });
      }
    }
  }

  Widget _buildList(List<ListTile> dayList) => ListView(
      // this is from backend events
      children: dayList);

  ListTile _tile(String title, String subtitle, String time, int myKey) {
    var defaultColor = Colors.black38;
    if (!cores.containsKey(myKey)) {
      cores[myKey] = defaultColor;
    }

    return ListTile(
      //key: myKey,
      title: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(subtitle),
      leading: Text(time),
      trailing: IconButton(
        icon: Icon(Icons.calendar_today, color: cores[myKey]),
        onPressed: () {
          print('cor em ' + myKey.toString());
          print(cores[myKey]);
          print('fui carregado em ' + myKey.toString());
          setState(() {
            if (isEnabled.containsKey(myKey)) {
              cores.remove(myKey);
              cores[myKey] = defaultColor;
              isEnabled.remove(myKey);
            } else {
              isEnabled[myKey] = true;
              cores[myKey] = Colors.black;
            }

            cores = Map.from(cores);
            list_23 = List.from(list_23);
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
            _buildList(list_23),
            _buildList(list_24),
            _buildList(list_25),
            _buildList(list_26)
          ],
        ),
      ),
    );
  }
}
