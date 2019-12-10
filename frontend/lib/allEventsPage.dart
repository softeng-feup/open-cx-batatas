import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Post> fetchPost() async {
  final response =
      await http.get('http://diogo98s.pythonanywhere.com/api/v1/events/');

  if (response.statusCode == 200) {
    print("Passed");
    print(response.body.length);
    // If the call to the server was successful, parse the JSON.
    return Post.fromJson(json.decode(response.body)[0]);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String name;
  final String description;
  final String start_time;
  final String end_time;
  final String updates;

  Post(
      {this.name,
      this.description,
      this.start_time,
      this.end_time,
      this.updates});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
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
  // Color _iconColor = Colors.black38;
  var cores = {};
  var isEnabled = {};

  Future<Post> post;
  @override
  void initState() {
    super.initState();
    post = fetchPost();
  }

  Widget _buildList() => ListView(
        // this is from backend events
        children: [
          _tile(
              'Registration',
              'Register to receive your accredition at this week.',
              '09:00\n10:00',
              1),
          _tile('Big Data Today', 'An prespective with Zé Manel',
              '10:00\n10:20', 2),
          _tile('The end of Blockchain', 'CEO from ABBT', '10:20\n10:50', 3),
          _tile(
              'JavaScript Workshop',
              'Learn how to programe in Js, just for begginers.',
              '11:00\n12:00',
              4),
          _tile('Do you need a router?',
              'Workshop about configure a router by Cisco ', '12:00\n13:00', 5),
          Divider(),
          _tile('Lunch Time', 'Meet in coffe-lunch', '', 6),
          Divider(),
          _tile('The Future Today', 'CTO from Airbnb', '14:00\n14:40', 7),
          _tile('Robot from the past', 'CEO from IBM', '14:40\n15:00', 8),
          _tile('Build a robot', 'Learn how to build a robot, IBM',
              '15:00\n16:20', 9),
          _tile('React Native', 'For begginers by Natixis', '16:00\n17:30', 10),
        ],
      );

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
          print('fui carregado em ' + myKey.toString());
          setState(() {
            if (isEnabled.containsKey(myKey)) {
              cores.remove(myKey);
              isEnabled.remove(myKey);
            } else {
              isEnabled[myKey] = true;
              cores[myKey] = Colors.black;
            }
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
        body: Center(
          child: FutureBuilder<Post>(
            future: post,
            builder: (context, snapshot) {
              print(post.toString());
              if (snapshot.hasData) {
                return Text(snapshot.data.name);
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
        //body: TabBarView(
        //children: [_buildList(), _buildList(), _buildList(), _buildList()],
        //),
      ),
    );
  }
}
