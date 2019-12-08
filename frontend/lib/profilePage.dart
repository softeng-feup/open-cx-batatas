import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final AssetImage _profilePic = AssetImage("lib/assets/images/elonMusk.jpg");

  @override
  State<StatefulWidget> createState() {
    return ProfilePageState(_profilePic);
  }
}

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

class ProfilePageState extends State<ProfilePage> {
  final AssetImage _profilePic;

  final name = "Sérgio Conceição";
  final position = "Student";
  final job = "Super Company";
  final interest = "Bird Watching";
  final elementPadding = 4.0;

  ProfilePageState(this._profilePic);

  @override
  Widget build(BuildContext context) {
    //"draw" method
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          CircleAvatar(
            //primeiro CircleAvatar para a borda
            radius: screenWidth(context) * 0.3,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://i.imgur.com/hlCsBwp.jpg"), //linkar imagens de perfil da base de dados
              radius: screenWidth(context) * 0.25,
            ),
          ),
          // nome da pessoa
          Container(
            width: screenWidth(context) * 0.55,
            height: screenHeight(context) * 0.07,
            color: Colors.transparent,
            padding: EdgeInsets.only(
              top: screenHeight(context) * 0.01,
              bottom: screenHeight(context) * 0.01,
              left: screenWidth(context) * 0.01,
              right: screenWidth(context) * 0.01,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)),
              ),
              padding: EdgeInsets.only(
                top: screenHeight(context) * 0.01,
                bottom: screenHeight(context) * 0.01,
                left: screenWidth(context) * 0.01,
                right: screenWidth(context) * 0.01,
              ),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 17, // fazer relativo ao ecra
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // cenas sobre a pessoa
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.work,
                      // color: Colors.pink,
                      size: 30.0, // relativo ao ecra
                      semanticLabel: 'work icon',
                    ),
                    Text(" - " + position + " at " + job),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      // color: Colors.pink,
                      size: 30.0, // relativo ao ecra
                      semanticLabel: 'work icon',
                    ),
                    Text(" - " + "Likes " + interest),
                    //if(speaker) Text("Speaker at OpenCX"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.mic,
                      // color: Colors.pink,
                      size: 30.0, // relativo ao ecra
                      semanticLabel: 'work icon',
                    ),
                    //if(speaker)
                    Text(" - Speaker at OpenCX"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
