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

double screenTextScale(BuildContext context) {
  return MediaQuery.textScaleFactorOf(context);
}

class ProfilePageState extends State<ProfilePage> {
  final AssetImage _profilePic;

  final name = "Sérgio Conceição";
  final position = "Student";
  final job = "Super Company";
  final interest = "Bird Watching";

  ProfilePageState(this._profilePic);

  @override
  Widget build(BuildContext context) {
    // "draw" method
    return Container(
      padding: EdgeInsets.all(10.0),
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
              child: FittedBox(
                fit: BoxFit.contain,
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
          ),
          // cenas sobre a pessoa
          // mainAxisAlignment: MainAxisAlignment.center,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.work,
                        // size: screenSize(context).aspectRatio*2, // relativo ao ecra
                        semanticLabel: 'work icon',
                      ),
                      Text(
                        " - " + position + " at " + job,
                        style: TextStyle(
                          fontSize: screenTextScale(context) * 15,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        // size: screenSize(context).aspectRatio *
                        //     0.03, // relativo ao ecra
                        semanticLabel: 'interests icon',
                      ),
                      Text(
                        " - " + "Likes " + interest,
                        style: TextStyle(
                          fontSize: screenTextScale(context) * 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mic,
                        // size: screenSize(context).aspectRatio *
                        //     0.03, // relativo ao ecra
                        semanticLabel: 'speaker icon',
                      ),
                      // if(speaker)
                      Text(
                        " - Speaker at OpenCX",
                        style:
                            TextStyle(fontSize: screenTextScale(context) * 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
