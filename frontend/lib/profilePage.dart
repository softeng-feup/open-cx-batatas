import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final AssetImage _profilePic = AssetImage("lib/assets/images/elonMusk.jpg");

  @override
  State<StatefulWidget> createState() {
    return ProfileText(_profilePic);
  }
}

class ProfileText extends State<ProfilePage> {
  final AssetImage _profilePic;

  final imageRadius = 100.0; //fazer relativo ao ecra (dont know how though)
  final name = "Elon Musk";
  final position = "Student";
  final job = "Super Company";
  final interest = "Bird Watching";
  final elementPadding = 4.0;

  ProfileText(this._profilePic);

  @override
  Widget build(BuildContext context) {
    //"draw" method
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            //primeiro CircleAvatar para a borda
            radius: imageRadius,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://i.imgur.com/hlCsBwp.jpg"), //linkar imagens de perfil da base de dados
              radius: imageRadius - 10.0,
            ),
          ),
          // nome da pessoa
          Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(elementPadding),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0)),
              ),
              padding: EdgeInsets.all(elementPadding),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // cenas sobre a pessoa
          Container(
            // padding: const EdgeInsets.all(10.0),
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
