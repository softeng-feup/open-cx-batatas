import 'package:flutter/material.dart';

class AllEventsPage extends StatefulWidget {
  AllEventsPage({Key key}) : super(key: key);
  @override
  _AllEventsPageState createState() => _AllEventsPageState();
}

class _AllEventsPageState extends State<AllEventsPage> {
  // Color _iconColor = Colors.black38;
  var cores = {};
  var isEnabled = {};

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
          _tile(
              'Do you need a router?',
              'Workshop about configure a router by Cisco ',
              '12:00\n13:00',
              5),
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
        body: TabBarView(
          children: [_buildList(), _buildList(), _buildList(), _buildList()],
        ),
      ),
    );
  }
}
